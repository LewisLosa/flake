{
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./_zsh.nix
    ./_packages.nix
  ];

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "25.11";
  };

  programs = {
    htop.enable = true;
    neofetch.enable = true;
    fastfetch.enable = true;
    nano.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}