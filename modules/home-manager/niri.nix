{ inputs, vars, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  xdg.configFile."niri/config.kdl".source = ./_niri/config.kdl;

# If you change the cursor, also update the "xcursor" variable in ./_niri/config.kdl
gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
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
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            { id = "ControlCenter"; useDistroLogo = true; }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
          ];
          center = [  
            { id = "Workspace"; hideUnoccupied = false; labelMode = "none"; }
          ];
          right = [
            { id = "Battery"; alwaysShowPercentage = false; warningThreshold = 30; }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };

      colorSchemes.predefinedScheme = "Monochrome";

      general = {
        avatarImage = "/home/${vars.username}/.face";
      };

      location = {
        monthBeforeDay = true;
        name = "Istanbul, Türkiye";
      };
    };
  };
}
