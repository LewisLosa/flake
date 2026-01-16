_: {
  services = {
    displayManager.sddm = {
      wayland.enable = true;
      enable = true;
    };
    gnome.gnome-keyring.enable = true;
    libinput.enable = true;
  };

  programs.ssh.enableAskPassword = true;

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}
