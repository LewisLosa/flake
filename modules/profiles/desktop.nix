# Desktop profile: aggregates all modules for a full desktop system with niri/DMS
{
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager-unstable.nixosModules.home-manager
    inputs.catppuccin.nixosModules.catppuccin
    ../nixos/base.nix
    ../nixos/printer.nix
    ../nixos/desktop/base.nix
    ../nixos/desktop/amdgpu.nix
    ../nixos/desktop/niri-dms
    ../../services/docker.nix
    ../../services/tailscale.nix
  ];

  home-manager.users.${vars.username} = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
      ../home-manager/base.nix
      ../home-manager/git.nix
      ../home-manager/desktop
      ../home-manager/desktop/niri-dms
    ];
  };
}
