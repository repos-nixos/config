{ pkgs, suites, ... }: {
  imports =
    suites.base ++
    [
      quark/hardware-configuration.nix
      ../profiles/daemons/chia-harvester
      ../profiles/core/minimalize
    ];

  nixpkgs.system = "aarch64-linux";

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  swapDevices = [{
    device = "/var/swapfile";
    size = 8192;
    randomEncryption.enable = true;
  }];

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  hardware.opengl = {
    enable = true;
    setLdLibraryPath = true;
    package = pkgs.mesa_drivers;
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  boot.loader.raspberryPi.firmwareConfig = ''
    gpu_mem=192
    disable_overscan=1
    dtparam=audio=on
  '';

  programs.captive-browser.interface = "wlan0";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
