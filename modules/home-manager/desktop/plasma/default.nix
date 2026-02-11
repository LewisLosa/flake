{
  inputs,
  lib,
  ...
}:
{
  # Plasma home-manager configuration
  # Uses Plasma's native secret/keyring stack (KWallet/Plasma Vault)
  # Uses KDE's nattive QT platform integration (no qt5ct/qt6ct)

  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./shortcuts.nix
  ];

  # Enable plasma-manager for KDE native integration
  programs.plasma = {
    enable = true;
    input.keyboard.layouts = [ { layout = "tr"; } ];
    workspace = {
      clickItemTo = "select";
      iconTheme = "Papirus-Dark";
    };
  };

  # QT Configuration - Use KDE native integration, NOT qt5ct/qt6ct
  # This ensures QT applications respect KDE Plasma settings
  qt = {
    enable = true;
    platformTheme.name = "kde"; # Use KDE's native QT platform
    style.name = "Breeze"; # Use Breeze via KDE, not via qt5ct overrides
  };

  # Set environment variables for KDE native QT integration
  # These ensure QT applications use KDE's platform theme
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "kde"; # KDE native platform theme
  };

  # Override the VSCode password-store setting for Plasma
  # Plasma uses KWallet/Plasma Vault instead of gnome-libsecret
  home.file.".vscode/argv.json".text = lib.mkForce ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "kwallet5"
    }
  '';

  # Stylix integration - available but not themed
  # The stylix module will handle theming if enabled at system level
}
