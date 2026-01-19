{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.windscribe-bin.nixosModules.default
  ];

  services = {
    windscribe.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  programs = {
    niri.enable = true;
    adb.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mako
    catppuccin-cursors
    xwayland-satellite
    swayidle
  ];
}
