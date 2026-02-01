{
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../nixos/base.nix
    ../nixos/printer.nix
    ../nixos/docker.nix
  ];

  home-manager.users.${vars.username} = {
    imports = [
      ../home-manager/base.nix
      ../home-manager/git.nix
    ];
  };
}
