{
  lib,
  ...
}:
{
  qt = {
    enable = false;
    # platformTheme.name = "qtct";
    # style.name = "Breeze";

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
        icon_theme = "Papirus-Dark";
      };
    };
  };

  xdg.configFile."qt6ct/qt6ct.conf" = lib.mkDefault {
    text = lib.generators.toINI { } {
      Appearance = {
        icon_theme = "Papirus-Dark";
      };
    };
  };
}
