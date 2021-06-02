{
  services.xserver.displayManager = {
    defaultSession = "lxqt";
    autoLogin.enable = true;
    autoLogin.user = "minecraft";
  };

  services.getty.autologinUser = "minecraft";
}
