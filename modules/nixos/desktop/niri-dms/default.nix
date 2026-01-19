{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.windscribe-bin.nixosModules.default
    ./sddm
  ];

  services = {
    windscribe.enable = true;
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  programs = {
    niri.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libnotify
    catppuccin-cursors
    xwayland-satellite
    swayidle
  ];
}
