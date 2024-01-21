{ config, pkgs, ... }:

{
  imports = [
    ./amd-opengl.nix
    ./amd-steam.nix
    ./autorun.nix
    ./boot.nix
    ./intel-opengl.nix
    ./intel-steam.nix
    ./polkit.nix
    ./services.nix
  ];
}
