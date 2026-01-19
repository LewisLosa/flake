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
      cider-2
      speedtest-cli
      curl
      dig
      figlet
      lolcat
      cowsay
      wget
      imagemagick
      openssl
      jq
      kopia
      statix
      qrencode
      tree
      microfetch
      yazi
    ]
    ++ (
      if osConfig.networking.hostName != "thinky" then
        [
          stow
          kdePackages.qqc2-desktop-style
          kdePackages.kio-extras
          kdePackages.kimageformats
          kdePackages.kdegraphics-thumbnailers
          ffmpegthumbnailer
          kdePackages.dolphin
          nautilus
          seahorse
          nil
          nixd
          bun
          just
          gnupg1
          ffmpeg
          sops
          zola
          nwg-look
          kitty
          zed-editor
          vscode
          pkgs-unstable.vesktop
        ]
      else
        [ ]
    );
}
