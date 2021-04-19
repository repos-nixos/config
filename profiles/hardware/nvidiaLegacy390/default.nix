{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

  # the legacy driver does not support offload mode
  hardware.nvidia.prime.sync.enable = true;
}
