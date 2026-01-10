{
  pkgs,
  vars,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "tr";
        variant = "";
      };
      desktopManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];

    libinput.enable = true;
    programs.ssh.enableAskPassword = true;
    environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}
