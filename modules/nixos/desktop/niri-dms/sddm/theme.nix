{theme, ...}: {
  catppuccin.sddm = {
    enable = true;
    inherit (theme) flavor accent;
    font = "Noto Sans";
    fontSize = "12";
    background = "${../../../_files/_sddm/bunnies-road.png}";
    loginBackground = true;
  };
}
