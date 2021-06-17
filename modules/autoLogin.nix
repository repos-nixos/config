{ config, lib, ... }:

# Control autoLogin on both X and TTY with one option

let cfg = config.services.autoLogin;
in
{
  options.services.autoLogin.user = lib.mkOption {
    type = with lib.types; nullOr str;
    default = null;
  };
  config = lib.mkIf (cfg.user != null) {
    services.xserver.displayManager = {
      autoLogin.enable = true;
      autoLogin.user = cfg.user;
    };

    services.getty.autologinUser = cfg.user;
  };
}
