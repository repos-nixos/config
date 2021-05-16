# settings to try and minimize disk footprint

{
  # enabled by default but superfluous when the root account is used
  # also less suid executables = good
  security.sudo.enable = false;
  security.polkit.enable = false;

  environment.defaultPackages = [ ];
}
