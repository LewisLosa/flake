{
  pkgs,
  ...
}:
{
  # If you change the cursor, also update the "xcursor" variable in ./_niri/config.kdl
  gtk = {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "catppuccin-mocha-dark-cursors";
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-cursor-theme-name=catppuccin-mocha-dark-cursors
      '';
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".force = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
  };
}
