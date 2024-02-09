{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./kdenlive.nix
    ./kitty.nix
    ./neofetch.nix
    ./packages.nix
    ./rofi.nix
    ./starship.nix
    ./style1-waybar.nix
    ./style2-waybar.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./zsh.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
