{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Enable &/ Configure Programs
    # ./alacritty.nix
    ./bash.nix
    ./gtk-qt.nix
    # ./hyprland.nix
    # ./kdenlive.nix
    ./kitty.nix
    ./mime.nix
    ./neofetch.nix
    ./packages.nix
    ./starship.nix
    # ./waybar.nix
    # ./wlogout.nix
    # ./swappy.nix
    # ./swaylock.nix
    # ./swaync.nix
    # ./wezterm.nix
    # ./zeroad.nix
    ./zsh.nix
    ./nushell.nix
    # ./hyprpaper.nix
    # ./hyprcursor.nix

    # Place Home Files Like Pictures
    ./files.nix

    # community repo
    ./nur.nix

    ./r.nix
    # ./vivaldi.nix
    ./rust.nix

    ./apps
    ./hypr
  ];
}
