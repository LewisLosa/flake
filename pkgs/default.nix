{ pkgs, ... }:
let
  aya = import ./aya { inherit pkgs; };
  windscribe = import ./windscribe { inherit pkgs; };
in
{
  environment.systemPackages = [
    aya
    windscribe
  ];
}
