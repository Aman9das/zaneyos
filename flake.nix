{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    theme = "tokyo-night-storm";
    waybarStyle = "style2"; # can be style1-2
    borderAnim = "on"; # anything other than on disables anim borders in Hyprland
    browser = "firefox";
    wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
    wallpaperDir = "/home/${username}/Pictures/Wallpapers";
    flakeDir = "/home/${username}/zaneyos";
    # Driver selection profile
    # Options include amd (tested), intel, nvidia
    # GPU hybrid options: intel-nvidia, intel-amd
    # vm for both if you are running a vm
    cpuType = "amd";
    gpuType = "amd";
    # Run: sudo lshw -c display to find this info
    # This is needed ONLY for hybrid nvidia offloading
    # Run: nvidia-offload (insert program name)
    intel-bus-id = "PCI:0:2:0";
    nvidia-bus-id = "PCI:14:0:0";

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
          inherit cpuType; inherit theKBDLayout;
          inherit theLCVariables; inherit gpuType;
        };
	    modules = [ ./system.nix
          home-manager.nixosModules.home-manager {
	        home-manager.extraSpecialArgs = { inherit username; 
              inherit gitUsername; inherit gitEmail;
              inherit theKBDLayout; inherit inputs;
              inherit theme; inherit browser;
              inherit wallpaperDir; inherit wallpaperGit;
              inherit flakeDir; inherit gpuType;
              inherit cpuType; inherit waybarStyle;
              inherit borderAnim;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
	        home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
	        home-manager.users.${username} = import ./home.nix;
	      }
	    ];
      };
    };
  };
}
