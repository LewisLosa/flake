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
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
}
