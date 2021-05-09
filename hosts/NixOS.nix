{ suites, ... }:
{
  imports = suites.base ++ [
    ../users/nixos
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "dm-raid" ];

  programs.gnupg.agent.pinentryFlavor = "curses";

  networking.networkmanager.enable = true;

  isoImage.contents = [{
    source = ../secrets/id_niximg;
    target = "id_niximg";
  }];
  programs.ssh.extraConfig = ''
    IdentityFile /iso/id_niximg
  '';

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
