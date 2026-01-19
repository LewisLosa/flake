{
  imports = [
    ./fonts.nix
    ./apps
  ];
  # inspo: https://github.com/microsoft/vscode/issues/187338#issuecomment-1626487441
  home.file.".vscode/argv.json".text = ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "gnome-libsecret"
    }
  '';
}
