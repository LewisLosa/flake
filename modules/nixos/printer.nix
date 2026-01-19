{pkgs, ...}: {
  services = {
    system-config-printer.enable = true;

    printing = {
      enable = true;
      drivers = [pkgs.gutenprint];
    };
  };
}
