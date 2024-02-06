{ config, ... }:

let inherit (import ../../options.nix) nfs; in
lib.mkIf ("${nfs}" == "on") {
  fileSystems."${nfsMountPoint}" = {
    device = "${nfsDevice}";
    fsType = "nfs";
  };
  services = {
    rpcbind.enable = true;
    nfs.server.enable = true;
  };
}
