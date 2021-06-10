{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.dconf-editor
    gnome3.gnome-tweaks
  ];

  services.gnome.gnome-keyring.enable = lib.mkForce false; # conflicts w/ ssh
}

