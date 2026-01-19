{
  lib,
  vars,
  ...
}:
let
  colorSchemePath = "/home/${vars.username}/.config";
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Breeze";
  };

  xdg.configFile = {
    "kdeglobals".text = ''
      [General]
      ColorScheme=DankMatugen

      [Icons]
      Theme=Papirus-Dark
    '';

    "qt5ct/qt5ct.conf" = lib.mkDefault {
      text = lib.generators.toINI { } {
        Appearance = {
          custom_palette = "true";
          icon_theme = "Papirus-Dark";
          color_scheme_path = "${colorSchemePath}/qt5ct/colors/matugen.conf";
          style = "Breeze";
        };
      };
    };

    "qt6ct/qt6ct.conf" = lib.mkDefault {
      text = lib.generators.toINI { } {
        Appearance = {
          custom_palette = "true";
          icon_theme = "Papirus-Dark";
          color_scheme_path = "${colorSchemePath}/qt6ct/colors/matugen.conf";
          style = "Breeze";
        };
      };
    };
  };
}
