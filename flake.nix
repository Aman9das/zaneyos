{
    description = "ZaneyOS Workstation Edition";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland.url = "github:hyprwm/Hyprland";
    };
    outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs:
    let
        system = "x86_64-linux";
    in
    {
        nixosConfigurations = {
            hyprnix = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    ./nixos/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useUserPackages = true;
                            useGlobalPkgs = true;
                            users.zaney = ./nixos/home.nix;
                        };
                    }
                ];
            };
        };
        homeConfigurations."zaney@hyprnix" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;

            modules = [
                hyprland.homeManagerModules.default
                {wayland.windowManager.hyprland.enable = true;}
            ];
        };
    };
}
