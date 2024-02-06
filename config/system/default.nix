{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    ./autorun.nix
    ./boot.nix
    ./displaymanager.nix
    ./hwclock.nix
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./neovim.nix
    ./nfs.nix
    ./ntp.nix
    ./nvidia.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./steam.nix
    ./vm.nix
  ];
}
