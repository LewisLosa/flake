{
  pkgs-unstable,
  pkgs,
  ...
}: {
  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;

      settings = {
        general = {
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'good games '";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
  environment.systemPackages = [
    pkgs-unstable.mangohud
    pkgs-unstable.goverlay
  ];
}
