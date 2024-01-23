{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
    theKBDLayout = "us";
    theLCVariables = "en_US.UTF-8";
    theTimezone = "America/Chicago";
    theme = "catppuccin-mocha";
    browser = "firefox";
    wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
    wallpaperDir = "/home/${username}/Pictures/Wallpapers";
    flakeDir = "/home/${username}/zaneyos";
    # Configuration option profile
    # default options amd-desktop, intel-laptop, vm (WIP)
    deviceProfile = "amd-desktop";

    pkgs = import nixpkgs {
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
          inherit gitUsername; inherit theTimezone;
          inherit gitEmail; inherit theLocale;
          inherit wallpaperDir; inherit wallpaperGit;
          inherit deviceProfile; inherit theKBDLayout;
          inherit theLCVariables;
        };
	    modules = [ ./system.nix
          home-manager.nixosModules.home-manager {
	        home-manager.extraSpecialArgs = { inherit username; 
              inherit gitUsername; inherit gitEmail;
              inherit inputs; inherit theme;
              inherit browser; inherit wallpaperDir;
              inherit wallpaperGit; inherit flakeDir;
              inherit deviceProfile;
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
