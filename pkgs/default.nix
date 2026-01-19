{ pkgs, ... }:
let
  aya = import ./aya { inherit pkgs; };
in
{
  environment.systemPackages = [ aya ];
}
