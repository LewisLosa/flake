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
    pkgs-unstable.claude-code

    # development
    bun

    # nix language
    nil
    nixd

    # other
    zola
    nwg-look
  ];
}
