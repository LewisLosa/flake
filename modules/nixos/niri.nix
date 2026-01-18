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
    gnome.gnome-keyring.enable = true; # secret service
    gvfs.enable = true; # for nautilus
  };

  security = {
    polkit.enable = true; # polkit
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
    # ... maybe other stuff
  ];
}
