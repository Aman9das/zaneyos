{ pkgs, config, ... }:
{
  imports = [
    ./neovim.nix
    ./r.nix
    ./zsh.nix
    ./bash.nix
    ./rust.nix
    ./kitty.nix
    ./nushell.nix
    ./starship.nix
    ./c.nix
  ];
}
