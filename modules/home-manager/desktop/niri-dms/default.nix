{
  imports = [
    ./dms.nix
    ./catppuccin.nix
    ./qt.nix
  ];

  # Niri-DMS uses GNOME keyring - ensure VSCode uses gnome-libsecret
  # This overrides the default desktop setting
  home.file.".vscode/argv.json".text = ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "gnome-libsecret"
    }
  '';
}
