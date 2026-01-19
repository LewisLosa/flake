# some pieces taked from https://github.com/eh8/chenglab/blob/main/modules/nixos/base.nix
{
  pkgs,
  vars,
  ...
}:
{
  imports = [
    ./_packages.nix
  ];
  # variables
  time.timeZone = "${vars.timezone}";
  console.keyMap = "${vars.keyMap}";
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

  # TODO After configuring sops-nix, change the value of users.mutableUsers to fas
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "windscribe"
      "adbusers"
    ];
    openssh.authorizedKeys.keys = [
      vars.sshPublicKey
    ];
    # hashedPasswordFile = "";
  };

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    tailscale.enable = true;
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
    fstrim.enable = true; # for ssd
  };

  # inspo: https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1658731959
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
