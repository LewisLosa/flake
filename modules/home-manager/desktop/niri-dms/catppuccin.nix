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
}
