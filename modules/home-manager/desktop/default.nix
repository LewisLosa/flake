{
  imports = [
    ./fonts.nix
    ./apps
  ];
  home.file.".vscode/argv.json".text = ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "gnome-libsecret"
    }
  '';
}
