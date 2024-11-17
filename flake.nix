{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-colors.url = "github:misterio77/nix-colors";

    # hyprwm
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland/?rev=9a09eac79b85c846e3a865a9078a3f8ff65a9259&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprscroller = {
      url = "github:dawsers/hyprscroller";
      inputs.hyprland.follows = "hyprland";
    };

    # impermanence.url = "github:nix-community/impermanence";

    flatpaks.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      hyprland,
      nur,
      flatpaks,
      ...
    }:
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
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit pkgs-unstable;
            inherit inputs;
            inherit username;
            inherit hostname;
            inherit host;
          };
          modules = [
            ./system.nix
            # impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            flatpaks.nixosModules.nix-flatpak

            nur.nixosModules.nur

            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
                # inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
                inherit system;
                inherit pkgs-unstable;
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
