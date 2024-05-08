{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-stable, home-manager, impermanence, ... }:
  let
    system = "x86_64-linux";
    host = "E14nix";
    inherit (import ./hosts/${host}/options.nix) username hostname;

    pkgs = import nixpkgs {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
	specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
          inherit host; inherit pkgs-stable;
        };
	modules = [ 
	  ./system.nix
	  impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager {
	    home-manager.extraSpecialArgs = {
              inherit username; inherit inputs;
              inherit host;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
              inherit pkgs-stable;
            };
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
	    home-manager.users.${username} = import ./users/default/home.nix;
	  }
	];
      };
    };
  };
}
