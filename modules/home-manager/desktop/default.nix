{ lib, ... }:
{
  imports = [
    ./fonts.nix
    ./apps
  ];
  # inspo: https://github.com/microsoft/vscode/issues/187338#issuecomment-1626487441
  # Default password-store setting - can be overridden by desktop-specific modules
  home.file.".vscode/argv.json".text = lib.mkDefault ''
    {
      // Fixes the "an OS keyring couldn't be identified for
      // storing the encryption..." error
      "password-store": "kwallet5"
    }
  '';
}
