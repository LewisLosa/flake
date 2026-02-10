{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./apps
  ];
  services = {
    libinput.enable = true;
    flatpak.enable = true;
  };

  # GNOME keyring is only enabled when using Niri-DMS
  # Plasma uses its own KWallet-based secret management
  # These settings are moved to the niri-dms module to avoid conflicts
  programs.seahorse.enable = lib.mkDefault false;
  services.gnome.gnome-keyring.enable = lib.mkDefault false;

  services.xserver = {
    displayManager = {
      sessionCommands = ''
        export SSH_AUTH_SOCK
      '';
    };
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    nix-ld.enable = true;
  };

  # android-tools for adb command (systemd 258 handles uaccess rules automatically)
  environment.systemPackages = [pkgs.android-tools];

  # Desktop-only services
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.accounts-daemon.enable = true;
}
