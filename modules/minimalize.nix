{ config, lib, pkgs, ... }:

# settings to try and minimize disk footprint

let cfg = config.environment.minimalize;
in
{
  options.environment.minimalize = with lib; {
    enable = mkEnableOption "try and mimimize system closure size by cutting fluff";
    fakeSudo = mkEnableOption "remove sudo and add an alias";
  };
  config = lib.mkIf cfg.enable
    {
      security.polkit.enable = false;

      environment.defaultPackages = [ ];

    } // lib.mkIf cfg.fakeSudo {
    security.sudo.enable = false;
    environment.systemPackages = [
      # a fake sudo for some measure of compatibility
      (pkgs.writeShellScriptBin "sudo" ''
        exec "$@"
      '')
    ];
  };
}
