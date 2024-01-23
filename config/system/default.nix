{ config, pkgs, ... }:

{
  imports = [
    ./amd-opengl.nix
    ./steam.nix
    ./autorun.nix
    ./boot.nix
    ./displaymanager.nix
    ./intel-opengl.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
  ];
}
