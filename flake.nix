# this is my flake
{
  description = "A simple NixOS flake for sengozhome :=)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      vars = import ./vars.nix;
      theme = import ./theme.nix;

      system = "x86_64-linux";
      systems = [ system ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      mkNixOSConfig =
        path:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              vars
              theme
              pkgs-unstable
              ;
          };
          modules = [ path ];
        };
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      devShells = forAllSystems (system: {
        default = import ./modules/shell.nix {
          inherit pkgs-unstable;
        };
      });
      nixosConfigurations = {
        yoga = mkNixOSConfig ./machines/yoga;
        asus = mkNixOSConfig ./machines/asus;
        thinky = mkNixOSConfig ./machines/thinky;
        konata = mkNixOSConfig ./machines/konata;
        isochan = mkNixOSConfig ./machines/isochan;
      };
    };
}
