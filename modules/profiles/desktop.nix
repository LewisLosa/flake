# Desktop profile: aggregates all modules for a full desktop system with KDE Plasma
# Niri-DMS is available but not enabled by default - import it explicitly to use
{
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager-unstable.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ../nixos/base.nix
    ../nixos/printer.nix
    ../nixos/desktop/base.nix
    ../nixos/desktop/amdgpu.nix
    ../nixos/desktop/plasma
    ../../services/docker.nix
    ../../services/tailscale.nix
  ];

  home-manager.users.${vars.username} = {
    imports = [
      ../home-manager/base.nix
      ../home-manager/git.nix
      ../home-manager/desktop
      ../home-manager/desktop/plasma
    ];
  };
}
