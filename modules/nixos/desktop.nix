{
  pkgs,
  vars,
  ...
}: {
  services.xserver = {
    enable = true;

    xkb = {
      layout = "tr";
      variant = "";
    };

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome.enable = true;
  };

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  services.libinput.enable = true;

  programs.ssh.enableAskPassword = true;

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}