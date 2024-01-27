{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    ./autorun.nix
    ./boot.nix
    ./displaymanager.nix
    ./intel-gpu.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./steam.nix
  ];
}
