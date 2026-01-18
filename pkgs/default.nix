# inspo. https://codeberg.org/Ti-mmm/nixos-config/src/branch/main/pkgs/cider3/default.nix
{ pkgs, ... }:
let
  aya = import ./aya { inherit pkgs; };
in
{
  environment.systemPackages = [
    aya
  ];
}
