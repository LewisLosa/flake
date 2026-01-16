# inspo. https://codeberg.org/Ti-mmm/nixos-config/src/branch/main/pkgs/cider3/default.nix
{pkgs, ...}: let
  cider3 = import ./cider {inherit pkgs;};
in {
  environment.systemPackages = [
    cider3
  ];
}
