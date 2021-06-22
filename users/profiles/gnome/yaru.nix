{ pkgs, ... }:

{
  home.packages = [ pkgs.yaru-theme ];

  gtk.theme.name = "Yaru";
  gtk.iconTheme.name = "Yaru";

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [ pkgs.gnomeExtensions.gnome-shell-extension-user-themes.extensionUuid ];
    "org/gnome/shell/extensions/user-theme".name = "Yaru-light";
    "org/gnome/desktop/interface".gtk-theme = "Yaru";
    "org/gnome/desktop/interface".icon-theme = "Yaru";
  };
}
