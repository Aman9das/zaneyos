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
    # ./fonts.nix
    ./kitty.nix
    ./mime.nix
    ./neofetch.nix
    ./packages.nix
    ./starship.nix
    ./zsh.nix
    ./nushell.nix

    # Place Home Files Like Pictures
    ./files.nix

    # community repo
    ./nur.nix

    ./r.nix
    ./rust.nix

    ./apps
    ./hypr
  ];
}
