{
  lib,
  ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Breeze";

  };

  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=DankMatugen

    [Icons]
    Theme=Papirus-Dark
  '';

  xdg.configFile."qt5ct/qt5ct.conf" = lib.mkDefault {
    text = lib.generators.toINI { } {
      Appearance = {
        custom_palette = "true";
        icon_theme = "Papirus-Dark";
        color_scheme_path = "/home/eyups/.config/qt5ct/colors/matugen.conf";
        style = "Breeze";
      };
    };
  };

  xdg.configFile."qt6ct/qt6ct.conf" = lib.mkDefault {
    text = lib.generators.toINI { } {
      Appearance = {
        custom_palette = "true";
        icon_theme = "Papirus-Dark";
        color_scheme_path = "/home/eyups/.config/qt6ct/colors/matugen.conf";
        style = "Breeze";
      };
    };
  };
}
