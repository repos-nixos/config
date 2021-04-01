{ pkgs, ... }:

{
  hardware.keyboard.teck.enable = true;
  environment.systemPackages = [ pkgs.teck-programmer ];
}
