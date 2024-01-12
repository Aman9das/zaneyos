{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    hostname = "hyprnix";
    username = "zaney";
    pkgs = import nixpkgs {
      inherit system;
      config = {
	  allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
	    specialArgs = { inherit system; inherit inputs; inherit username; inherit hostname };
	    modules = [ ./laptop/configuration.nix
          home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.zaney = import ./home.nix;
	      }
	    ];
      };
      workstation = nixpkgs.lib.nixosSystem {
	    specialArgs = { inherit system; inherit inputs; };
	    modules = [ ./workstation/configuration.nix
          home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.${username} = import ./home.nix;
	      }
	    ];
      };
    };
  };
}
