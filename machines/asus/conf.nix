{
  inputs,
  pkgs-unstable,
  vars,
  outputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-conf.nix
    ./../../modules/nixos/desktop.nix
    ./../../modules/nixos/catppuccin.nix
    ./../../modules/nixos/niri.nix
    ./../../modules/nixos/base.nix
    ./../../modules/nixos/printer.nix
    ./../../modules/nixos/amdgpu.nix
    ./../../modules/nixos/kdeconnect.nix
    ./../../modules/nixos/catppuccin.nix
    ./../../pkgs/default.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        vars
        pkgs-unstable
        ;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    backupCommand = ''
      mv -f "$1" "$1.bak"
    '';

    users = {
      "${vars.username}" = {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
          ./../../modules/home-manager/catppuccin.nix
          ./../../modules/home-manager/niri.nix
          ./../../modules/home-manager/base.nix
          ./../../modules/home-manager/zen.nix
          ./../../modules/home-manager/fonts.nix
          ./../../modules/home-manager/git.nix
          ./../../modules/home-manager/dms.nix
          ./../../modules/home-manager/kdeconnect.nix
          ./../../modules/home-manager/qt.nix
        ];
      };
    };
  };

  networking.hostName = "asus";
  system.stateVersion = "25.11";
}
