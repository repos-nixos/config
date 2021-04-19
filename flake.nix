{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos.url = "nixpkgs/nixos-unstable";
      latest.url = "nixpkgs";
      digga.url = "github:divnix/digga";

      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "latest";
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";
      impermanence.url = "github:nix-community/impermanence";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "latest";
      nixos-hardware.url = "github:nixos/nixos-hardware";

      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";
    };

  outputs = inputs@{ self, pkgs, digga, nixos, home, impermanence, nixos-hardware, nur, ... }:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = import nixpkgs/config.nix { inherit (nixos) lib; };

      channels = {
        nixos = {
          imports = [ (digga.lib.importers.overlays ./overlays) ];
          overlays = [
            ./pkgs/default.nix
            pkgs.overlay # for `srcs`
            nur.overlay
          ];
        };
        latest = { };
      };

      lib = import ./lib { lib = digga.lib // nixos.lib; };

      sharedOverlays = [
        (final: prev: {
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          modules = ./modules/module-list.nix;
          externalModules = [
            { _module.args.ourLib = self.lib; }
            home.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            ./modules/customBuilds.nix
          ];
        };

        imports = [ (digga.lib.importers.hosts ./hosts) ];
        hosts = {
          /* set host specific properties here */
          NixOS = { };
        };
        profiles = [ ./profiles ./users ];
        suites = { profiles, users, ... }: with profiles; rec {
          base = [ core users.nixos users.root ];
          gnome = [ graphical graphical.gnome ];
          allTools = with tools; [
            tools # the root
            jdk
            podman
            wireshark
          ];

          workstation = base ++ allTools ++ [
            users.louis
            users.louis.singleUser
            misc.sign-store-paths
            network.nfs
            network.printers
            network.keybase
          ];

          laptop = workstation ++ [
            profiles.laptop
          ];

          buildServer = [
            misc.sign-store-paths
            network.nix-build-server
            network.nix-serve
          ];
        };
      };

      home = {
        modules = ./users/modules/module-list.nix;
        externalModules = [ ];
        profiles = [ ./users/profiles ];
        suites = { profiles, ... }: with profiles; rec {
          base = [ direnv git ];
        };
      };

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";

    }
  ;
}
