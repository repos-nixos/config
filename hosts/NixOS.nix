{ suites, ... }:
{
  ### root password is empty by default ###
  imports = suites.base;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  isoImage.contents = [ {
    source = ../secrets/id_niximg;
    target = "id_niximg";
  } ];
  programs.ssh.extraConfig = ''
    IdentityFile /iso/id_niximg
  '';

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
