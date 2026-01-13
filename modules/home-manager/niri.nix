{
  pkgs,
  ...
}:
{
  imports = [
    ./dms.nix
  ];

  # xdg.configFile."niri/config.kdl".source = ./_niri/config.kdl;
  programs.vscode.enable = true;
  # If you change the cursor, also update the "xcursor" variable in ./_niri/config.kdl
  gtk = {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
    };
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 24;
  };
}
