{ pkgs, lib, ... }:
let
  accent = "lavender";
  flavor = "mocha";
in
{
  # Catppuccin global configuration
  catppuccin = lib.mkForce {
    enable = true;
    flavor = flavor;
    accent = accent;

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
      flavor = flavor;
    };

    gtk.icon = {
      enable = true;
      accent = accent;
      flavor = flavor;
    };
  };

  # GTK theme configuration (manual, since catppuccin.gtk module was removed)
  gtk = lib.mkForce {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = accent;
        flavor = flavor;
      };
    };
    theme = {
      name = "catppuccin-${flavor}-${accent}-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ accent ];
        size = "standard";
        tweaks = [ ];
        variant = flavor;
      };
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  # Pointer cursor configuration
  home.pointerCursor = lib.mkForce {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-${flavor}-dark-cursors";
    package = pkgs.catppuccin-cursors."${flavor}Dark";
    size = 16;
  };

  xdg.configFile."gtk-4.0/gtk.css".force = true;
}
