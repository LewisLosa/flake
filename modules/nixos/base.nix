{
  inputs,
  vars,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./_packages.nix
    ./ssh.nix
    ./boot.nix
    ./user.nix
  ];

  time.timeZone = vars.timezone;
  console.keyMap = vars.keyMap;

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
  };

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

  services = {
    fstrim.enable = true;
  };
  programs.zsh.enable = true;

  zramSwap.enable = true;
}
