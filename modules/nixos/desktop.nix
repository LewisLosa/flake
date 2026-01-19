{ ... }:
{
  services = {
    displayManager.sddm = {
      wayland.enable = true;
      enable = true;
    };
    gnome.gnome-keyring.enable = true;
    libinput.enable = true;
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    ssh.enableAskPassword = true;
    nix-ld.enable = true;
  };

  environment.variables.SSH_ASKPASS_REQUIRE = "prefer";
}
