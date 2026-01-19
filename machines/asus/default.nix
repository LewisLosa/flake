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
    backupFileExtension = "bak";
  };

  networking.hostName = "asus";
  system.stateVersion = "25.11";
}
