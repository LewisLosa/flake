{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./kdeconnect.nix
    ./zen.nix
  ];
  home.packages = with pkgs; [
    # dolphin
    kdePackages.dolphin
    kdePackages.qqc2-desktop-style
    kdePackages.kio-extras
    kdePackages.kimageformats
    kdePackages.kdegraphics-thumbnailers
    ffmpegthumbnailer

    # gui
    pavucontrol
    nautilus
    seahorse
    kitty
    zed-editor
    cider-2
    pkgs-unstable.windsurf
    pkgs-unstable.vscode
    pkgs-unstable.vesktop
    pkgs-unstable.postman

    # media
    pkgs-unstable.qimgv
    pkgs-unstable.mpv

    # games
    pkgs-unstable.prismlauncher
  ];
}
