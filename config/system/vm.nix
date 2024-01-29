{ pkgs, config, lib, cpuType, ... }:

lib.mkIf ("${cpuType}" == "vm") {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
}
