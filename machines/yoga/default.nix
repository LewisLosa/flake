{
  inputs,
  pkgs-unstable,
  vars,
  outputs,
  theme,
  ...
}: {
  imports = [
    ./hardware-conf.nix
    ./../../modules/profiles/desktop.nix
    ./../../modules/profiles/laptop.nix
    ./../../pkgs/default.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        vars
        theme
        pkgs-unstable
        ;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak-" + (inputs.self.shortRev or "dirty");
  };

  networking.hostName = "yoga";
  system.stateVersion = "25.11";
}
