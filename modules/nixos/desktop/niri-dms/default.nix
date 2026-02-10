{pkgs, ...}: {
  imports = [
    ./sddm
  ];

  services = {
    gvfs.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  programs = {
    niri.enable = true;
    # Enable GNOME keyring for Niri-DMS session
    seahorse.enable = true;
  };

  # GNOME keyring services for Niri-DMS
  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    sddm.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    catppuccin-cursors
    xwayland-satellite
    swayidle
  ];
}
