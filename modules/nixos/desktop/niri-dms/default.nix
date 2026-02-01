{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./sddm
  ];

  services = {
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
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
