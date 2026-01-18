# inspo. https://codeberg.org/Ti-mmm/nixos-config/src/branch/main/pkgs/cider3/default.nix
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
  inherit pname version src;
  pkgs = pkgs;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share

    # unless linked, the binary is placed in $out/bin/cursor-someVersion
    # ln -s $out/bin/${pname}-${version} $out/bin/${pname}
  '';

  extraBwrapArgs = [
    "--bind-try /etc/nixos/ /etc/nixos/"
  ];

  # vscode likes to kill the parent so that the
  # gui application isn't attached to the terminal session
  dieWithParent = false;

  extraPkgs =
    pkgs: with pkgs; [
      unzip
      autoPatchelfHook
      asar
      # override doesn't preserve splicing https://github.com/NixOS/nixpkgs/issues/132651
      (buildPackages.wrapGAppsHook3.override { inherit (buildPackages) makeWrapper; })
    ];
}
