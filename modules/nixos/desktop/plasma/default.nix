_: {
  # Plasma desktop environment - vanilla configuration
  # Uses Plasma's native secret manager / keyring stack (KWallet/Plasma Vault)
  # Uses KDE's native QT platform integration

  imports = [];

  # Keyboard layout - Turkish at system level
  # This ensures the layout is applied before desktop session starts
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "tr_TR.UTF-8";
    };
  };

  # Set console keyboard layout
  console.keyMap = "trq";
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };
  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };
  services = {
    # Enable KDE Plasma desktop environment
    desktopManager.plasma6.enable = true;

    # Use SDDM as display manager (standard for Plasma)
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      # Set Turkish keyboard layout in SDDM
      settings = {
        General = {
          InputMethod = "";
        };
      };
    };
    # Plasma uses its own keyring/secret management via KWallet
    # No need to enable GNOME keyring here
  };

  # Ensure XDG portal is configured for Plasma
  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };

  # Basic Plasma dependencies
  environment.systemPackages = [];

  # Environment variables for KDE native QT integration
  # These are set system-wide to ensure all sessions use KDE platform theme
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kde";
  };
}
