{ pkgs, config, ... }:

{
  imports = [
    ./mail.nix
    ./zeroad.nix
    ./blender.nix
    ./vivaldi.nix
  ];
}

