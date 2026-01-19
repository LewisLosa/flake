{ ... }:
let
  accent = "lavender";
  flavor = "mocha";
in
{
  # Catppuccin theme for SDDM
  catppuccin.sddm = {
    enable = true;
    flavor = flavor;
    accent = accent;
    font = "Noto Sans";
    fontSize = "12";
    background = "${./_sddm/bunnies-road.png}";
    loginBackground = true;
  };
}
