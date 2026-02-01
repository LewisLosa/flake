{
  config,
  pkgs-unstable,
  ...
}:
{
  sops.secrets."services.tailscale.authkey" = { };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.sops.secrets."services.tailscale.authkey".path;
    useRoutingFeatures = "server";
    extraUpFlags = [
      "--advertise-routes=10.0.0.0/16"
    ];
    package = pkgs-unstable.tailscale;
  };
}
