{ vars, ... }:
{
  imports = [
    ./_zsh.nix
    ./_packages.nix
  ];

  home = {
    inherit (vars) username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "25.11";
  };

  programs = {
    htop.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
