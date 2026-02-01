{
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../nixos/base.nix
    ../nixos/server

    ../../services/tailscale.nix
  ];

  home-manager.users.${vars.username} = {
    imports = [
      ../../services/docker.nix
      ../home-manager/base.nix
      ../home-manager/git.nix
    ];
  };
}
