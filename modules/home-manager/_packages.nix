{
  pkgs,
  pkgs-unstable,
  osConfig,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      figlet
      lolcat
      cowsay
      yazi
      microfetch
    ]
    ++ (
      if osConfig.networking.hostName != "thinky" then
        [
          # dolphin
          kdePackages.dolphin
          kdePackages.qqc2-desktop-style
          kdePackages.kio-extras
          kdePackages.kimageformats
          kdePackages.kdegraphics-thumbnailers
          ffmpegthumbnailer

          # gui
          nautilus
          seahorse
          kitty
          zed-editor
          vscode
          cider-2
          pkgs-unstable.vesktop

          # games
          pkgs-unstable.prismlauncher

          # tools
          stow
          just
          gnupg1
          ffmpeg
          sops

          # development
          bun

          # nix language
          nil
          nixd

          # other
          zola
          nwg-look
        ]
      else
        [ ]
    );
}
