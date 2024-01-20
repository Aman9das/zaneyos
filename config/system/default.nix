{ config, pkgs, ... }:

{
  imports = [
    ./amd-opengl.nix
    ./autorun.nix
    ./boot.nix
    ./intel-opengl.nix
    ./polkit.nix
    ./services.nix
  ];
}
