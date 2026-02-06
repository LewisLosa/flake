{...}: {
  imports = [
    ./theme.nix
  ];
  services = {
    xserver.displayManager.sddm = {
      wayland.enable = true;
      enable = true;
    };
  };
}
