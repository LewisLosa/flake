{
  pkgs,
  ...
}: {
    services.displayManager.sddm = {
      wayland.enable = true;
      enable = true;
    };

  services.libinput.enable = true;

  programs.ssh.enableAskPassword = true;

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}