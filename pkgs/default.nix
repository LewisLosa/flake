{ pkgs, ... }:
let
  aya = import ./aya { inherit pkgs; };
  windscribe = pkgs.callPackage ./windscribe { };
in
{
  environment.systemPackages = [
    aya
    windscribe
  ];
}
