{
  pkgs,
  lib,
  theme,
  ...
}: {
  catppuccin = lib.mkForce {
    enable = true;
    inherit (theme) flavor accent;

    kvantum = {
      enable = false;
      assertStyle = false;
    };
    qt5ct = {
      enable = false;
      assertStyle = false;
    };

    cursors = {
      enable = true;
      accent = "dark";
      inherit (theme) flavor;
    };

    gtk.icon = {
      enable = true;
      inherit (theme) accent flavor;
    };
  };

  gtk = lib.mkForce {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        inherit (theme) accent flavor;
      };
    };
    theme = {
      name = "catppuccin-${theme.flavor}-${theme.accent}-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [theme.accent];
        size = "standard";
        tweaks = [];
        variant = theme.flavor;
      };
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.pointerCursor = lib.mkForce {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-${theme.flavor}-dark-cursors";
    package = pkgs.catppuccin-cursors."${theme.flavor}Dark";
    size = 16;
  };

  xdg.configFile."gtk-4.0/gtk.css".force = true;
}
