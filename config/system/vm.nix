{
  pkgs,
  config,
  lib,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/options.nix) cpuType;
in
lib.mkIf ("${cpuType}" == "vm") {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
