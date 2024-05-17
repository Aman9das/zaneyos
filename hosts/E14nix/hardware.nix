# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.kernelParams = ["psmouse.synaptics_intertouch=0"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/be27ed0e-b902-4597-89db-28aabc196a8d";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-uuid/44b41656-54ac-4c59-afa0-60438970c4c7";
    fsType = "btrfs";
  };

  fileSystems."/mnt/Home" = {
    device = "/dev/disk/by-uuid/3d8db8ca-6606-4199-9eb7-8324279405e9";
    fsType = "btrfs";
    options = ["subvol=home"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EFA9-A776";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/bfdea7e1-68f1-4611-92f5-57352b5d2d31";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
