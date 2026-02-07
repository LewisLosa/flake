# this is my flake
{
  description = "A simple NixOS flake for sengozhome :=)";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager-unstable";
      };
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
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

    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
    };
  };

  outputs = {
    self,
    nixpkgs-stable,
    nixpkgs-unstable,
    home-manager-stable,
    home-manager-unstable,
    ...
  } @ inputs: let
    inherit (self) outputs;
    vars = import ./vars.nix;
    theme = import ./theme.nix;

    system = "x86_64-linux";
    systems = [system];
    forAllSystems = nixpkgs-stable.lib.genAttrs systems;

    # Helper to create pkgs from a nixpkgs input
    mkPkgs = nixpkgs:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    pkgs-stable = mkPkgs nixpkgs-stable;
    pkgs-unstable = mkPkgs nixpkgs-unstable;

    # Helper for desktop/laptop systems (uses unstable)
    mkDesktopConfig = path:
      nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            outputs
            vars
            theme
            pkgs-unstable
            ;
        };
        modules = [path];
      };

    # Helper for server systems (uses stable)
    mkServerConfig = path:
      nixpkgs-stable.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            outputs
            vars
            theme
            pkgs-stable
            ;
        };
        modules = [path];
      };
  in {
    formatter = forAllSystems (system: nixpkgs-stable.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (system: {
      default = import ./modules/shell.nix {
        inherit pkgs-unstable;
      };
    });

    nixosConfigurations = {
      # Desktop/Laptop systems - use unstable
      yoga = mkDesktopConfig ./machines/yoga;
      asus = mkDesktopConfig ./machines/asus;

      # Server systems - use stable
      thinky = mkServerConfig ./machines/thinky;
      konata = mkServerConfig ./machines/konata;

      # ISO installer - use stable
      isochan = mkServerConfig ./machines/isochan;
    };
  };
}
