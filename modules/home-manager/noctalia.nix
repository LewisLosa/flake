{
  inputs,
  vars,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "Battery";
              alwaysShowPercentage = false;
              warningThreshold = 30;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };

      colorSchemes.predefinedScheme = "Monochrome";

      general = {
        avatarImage = "/home/${vars.username}/face.jpg";
      };

      location = {
        monthBeforeDay = true;
        name = "Istanbul, Türkiye";
      };
    };
  };
}
