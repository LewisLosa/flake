_: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
