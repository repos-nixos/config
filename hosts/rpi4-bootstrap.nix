{ config, lib, modulesPath, pkgs, suites, ... }: {
  imports = suites.base ++ [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];
  nixpkgs.system = "aarch64-linux";

  programs.gnupg.agent.pinentryFlavor = "curses";

  sdImage.populateRootCommands = ''
    mkdir -m 700 -p ./files/root/
    cp ${../secrets/id_niximg} ./files/root/id_niximg
    chmod 600 ./files/root/id_niximg
  '';

  programs.ssh.extraConfig = ''
    IdentityFile /root/id_niximg
  '';

}
