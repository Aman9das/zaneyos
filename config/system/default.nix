{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    ./autorun.nix
    ./boot.nix
    ./displaymanager.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./nvidia.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./steam.nix
  ];
}
