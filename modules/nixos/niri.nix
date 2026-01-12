{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.windscribe-bin.nixosModules.default
  ];
  xdg.portal.config.niri = {
    "org.freedesktop.impl.portal.FileChooser" = ["gtk"]; # or "kde"
  };
  services.windscribe.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.niri.enable = true;
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};
  # install package
  environment.systemPackages = with pkgs; [
    mako
    catppuccin-cursors
    xwayland-satellite
    swaylock
    fuzzel
    mako
    swayidle
    stow
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];
}
