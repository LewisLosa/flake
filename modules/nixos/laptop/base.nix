{...}: {
  imports = [
    ./suspend.nix
  ];
  services.batteryNotifier = {
    enable = true;
    notifyCapacity = 10;
    suspendCapacity = 4;
  };
}
