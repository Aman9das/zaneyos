{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./gtk-qt.nix
    ./kitty.nix
    ./mime.nix
    # ./fastfetch.nix
    ./packages.nix
    ./starship.nix
    ./zsh.nix
    ./nushell.nix

    # Place Home Files Like Pictures
    ./files.nix

    # community repo
    ./nur.nix

    # language support
    ./r.nix
    ./rust.nix

    ./apps
    ./hypr
    ./vm
  ];
}
