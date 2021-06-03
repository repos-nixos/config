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

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
