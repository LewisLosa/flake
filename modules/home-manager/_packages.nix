{
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in {
  home = {
    packages = with pkgs;
      [
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
      ]
      ++ (
        if osConfig.networking.hostName != "thinky"
        then [
          # Below packages are for personal machines only; excluded from servers
          # inspo: https://discourse.nixos.org/t/how-to-use-hostname-in-a-path/42612/3
          bun
          just
          gnupg1
          ffmpeg
          nil
          nixd
          sops
          statix
          zola
          pkgs-unstable.localsend
        ]
        else [
          # server only
        ]
      );
  };
}
