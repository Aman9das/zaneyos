{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./style1-waybar.nix
    ./style2-waybar.nix
    ./swaync.nix
    ./swaylock.nix
    ./starship.nix
    ./neofetch.nix
    ./hyprland.nix
    ./kitty.nix
    ./rofi.nix
    ./bash.nix
    ./gtk-qt.nix

    # Install Programs & Scripts For User
    ./packages.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
