{ ... }:
{
  imports = [
    ./theme.nix
  ];
  services = {
    displayManager.sddm = {
      wayland.enable = true;
      enable = true;
    };
  };
}
