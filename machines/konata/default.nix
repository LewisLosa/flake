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
    ./../../modules/profiles/server.nix
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

  networking.hostName = "konata";
  system.stateVersion = "25.11";
}
