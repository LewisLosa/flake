{
  pkgs,
  vars,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./_packages.nix
  ];

  time.timeZone = vars.timezone;
  console.keyMap = vars.keyMap;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "gamemode"
    ];
    openssh.authorizedKeys.keys = [
      vars.sshPublicKey
    ];
  };

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;
    };
    accounts-daemon.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        PubkeyAuthentication = true;
      };
      openFirewall = true;
    };
    fstrim.enable = true;
  };

  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [
        ""
        "${pkgs.networkmanager}/bin/nm-online -q"
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  zramSwap.enable = true;
}
