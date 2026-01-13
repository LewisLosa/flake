{
  inputs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dms.homeModules.dankMaterialShell.default
    inputs.dms.homeModules.dankMaterialShell.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableKeybinds = true; # Sets static preset keybinds
      enableSpawn = true; # Auto-start DMS with niri and cliphist, if enabled
    };
    default.settings = {
      theme = "dark";
      dynamicTheming = true;
    };
  };
}
