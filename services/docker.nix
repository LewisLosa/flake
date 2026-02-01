{ pkgs, ... }:
{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  home.packages = with pkgs; [
    lazydocker
  ];
}
