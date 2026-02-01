{pkgs, ...}: {
  imports = [
    ./apps
  ];
  services = {
    libinput.enable = true;
    flatpak.enable = true;
  };

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];
  services.xserver = {
    displayManager.sessionCommands = ''
      export SSH_AUTH_SOCK
    '';
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
    adb.enable = true; # for my android phone :D
  };

  # Desktop-only services
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.accounts-daemon.enable = true;
}
