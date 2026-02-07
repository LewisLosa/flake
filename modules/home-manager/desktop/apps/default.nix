{pkgs, ...}: {
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
    rustdesk
    pavucontrol
    nautilus
    seahorse
    kitty
    zed-editor
    cider-2
    tor-browser
    antigravity
    windsurf
    vscode
    vesktop
    postman

    # media
    qimgv
    mpv

    # games
    prismlauncher
  ];
}
