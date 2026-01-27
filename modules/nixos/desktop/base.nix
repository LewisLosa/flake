{ pkgs, ... }:
{
  imports = [
    ./apps
  ];
  services = {
    gnome.gnome-keyring.enable = true;
    libinput.enable = true;
    flatpak.enable = true;
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    ssh = {
      enableAskPassword = true;
    };
    nix-ld.enable = true;
    adb.enable = true; # for my android phone :D
  };

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}
