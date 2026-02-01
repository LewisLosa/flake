{
  inputs,
  vars,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../nixos/base.nix
    ../nixos/docker.nix
    ../nixos/server
  ];

  home-manager.users.${vars.username} = {
    imports = [
      ../home-manager/base.nix
      ../home-manager/git.nix
    ];
  };
}
