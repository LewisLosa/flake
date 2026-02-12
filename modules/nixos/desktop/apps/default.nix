{pkgs, ...}: {
  imports = [
    ./kdeconnect.nix
    ./gamemode.nix
  ];

  environment.systemPackages = with pkgs; [
    ventoy-full
  ];
  # temp
  # inspo: https://github.com/ventoy/Ventoy/issues/3224
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.10"
  ];
}
