{ config, lib, ... }:

let inherit (import ../../options.nix) ntp; in
lib.mkIf ("${ntp}" == "on") {
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
}
