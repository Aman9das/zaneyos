{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    # User Variables
    hostname = "hyprnix";
    username = "zaney";
    gitUsername = "Tyler Kelley";
    gitEmail = "tylerzanekelley@gmail.com";
    theLocale = "en_US.UTF-8";
    theTimezone = "America/Chicago";
    theme = "atelier-cave-light";
    browser = "firefox";
    wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
    wallpaperDir = "/home/${username}/Pictures/Wallpapers";
    flakeDir = "/home/zaney/zaneyos";

    pkgs = import nixpkgs {
      inherit system;
      config = {
	  allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
	    specialArgs = { inherit system; inherit inputs;
            inherit username; inherit hostname; inherit gitUsername;
            inherit gitEmail; inherit theLocale; inherit theTimezone;
            };
	    modules = [ ./laptop/configuration.nix
          home-manager.nixosModules.home-manager {
	        home-manager.extraSpecialArgs = { inherit username;
                inherit gitUsername; inherit gitEmail; inherit theme;
                inherit browser;
                inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.${username} = import ./home.nix;
	      }
	    ];
      };
      workstation = nixpkgs.lib.nixosSystem {
	    specialArgs = { inherit system; inherit inputs; 
            inherit username; inherit hostname; inherit gitUsername;
            inherit gitEmail; inherit theLocale; inherit theTimezone;
            inherit wallpaperDir; inherit wallpaperGit;
        };
	    modules = [ ./workstation/configuration.nix
          home-manager.nixosModules.home-manager {
	        home-manager.extraSpecialArgs = { inherit username; 
                inherit gitUsername; inherit gitEmail; inherit inputs; inherit theme;
                inherit browser; inherit wallpaperDir; inherit wallpaperGit; inherit flakeDir;
                inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.${username} = import ./home.nix;
	      }
	    ];
      };
    };
  };
}
