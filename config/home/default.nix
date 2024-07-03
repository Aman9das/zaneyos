{ pkgs, config, ... }:
{
  imports = [
    # Enable &/ Configure Programs
    ./gtk-qt.nix
    ./mime.nix
    # ./fastfetch.nix
    ./packages.nix

    # Place Home Files Like Pictures
    ./files.nix

    # community repo
    ./nur.nix

    ./apps
    ./hypr
    ./vm
    ./dev
  ];
}
