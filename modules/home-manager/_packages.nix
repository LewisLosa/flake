{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    # fun
    figlet
    lolcat
    cowsay
    yazi
    microfetch

    # tools
    stow
    just
    gnupg1
    ffmpeg
    sops
    lazydocker

    # development
    pkgs-unstable.bun
    pkgs-unstable.nodejs

    # nix language
    nil
    nixd

    # other
    zola
    nwg-look
  ];
}
