{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./fusuma.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./swappy.nix
    ./swaync.nix
  ];
}
