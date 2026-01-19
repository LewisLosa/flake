{ pkgs, ... }:
let
  pname = "aya";
  version = "1.14.2";

  src = pkgs.fetchurl {
    url = "https://github.com/liriliri/aya/releases/download/v1.14.2/AYA-1.14.2-linux-x86_64.AppImage";
    sha256 = "sha256:27ac157324191973c121250c1f2bbaeee8fbff626cffd309605a1b7c1c2f6967";
  };

  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit
    pname
    version
    src
    pkgs
    ;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  extraBwrapArgs = [
    "--bind-try /etc/nixos/ /etc/nixos/"
  ];

  dieWithParent = false;

  extraPkgs =
    pkgs: with pkgs; [
      unzip
      autoPatchelfHook
      asar
      (buildPackages.wrapGAppsHook3.override { inherit (buildPackages) makeWrapper; })
    ];
}
