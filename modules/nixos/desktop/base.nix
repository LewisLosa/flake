{ ... }:
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
    nix-ld.enable = true;
    adb.enable = true; # for my android phone :D
  };

}
