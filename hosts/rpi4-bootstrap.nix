{ config, lib, modulesPath, pkgs, suites, ... }: {
  imports = suites.base ++ [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  programs.gnupg.agent.pinentryFlavor = "curses";
}
