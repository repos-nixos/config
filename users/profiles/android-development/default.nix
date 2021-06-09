{ lib, pkgs, ... }:
{
  home.packages = with pkgs;
    lib.optional (pkgs.system == "x86_64-linux") android-studio;
}
