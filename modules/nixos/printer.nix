{
  pkgs,
  config,
  lib,
  ...
}:
let
  isThinky = config.networking.hostName == "thinky";
in
{
  services = lib.mkMerge [
    {
      system-config-printer.enable = true;

      printing = {
        enable = true;
        drivers = [ pkgs.gutenprint ];
      };
    }

    (lib.mkIf isThinky {
      printing = {
        listenAddresses = [ "*:631" ];
        allowFrom = [ "all" ];
        browsing = true;
        defaultShared = true;
        openFirewall = true;
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = {
          enable = true;
          userServices = true;
        };
      };
    })
  ];
}
