{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dank-material-shell
    inputs.danksearch.homeModules.dsearch
  ];

  programs.dsearch = {
    enable = true;
  };
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = pkgs.dgop;
    quickshell.package = pkgs.quickshell;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
  #
  #systemd = {
  #  user.services.polkit-gnome-authentication-agent-1 = {
  #    Unit = {
  #      Description = "polkit-gnome-authentication-agent-1";
  #      After = "graphical-session.target";
  #    };
  #    Install = {
  #      WantedBy = [ "graphical-session.target" ];
  #    };
  #    Service = {
  #      Type = "simple";
  #      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #      Restart = "on-failure";
  #      RestartSec = 1;
  #      TimeoutStopSec = 10;
  #    };
  #  };
  #};
}
