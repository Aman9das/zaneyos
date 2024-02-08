{ config, lib, ... }:

let inherit (import ../../options.nix) printer; in
lib.mkIf (printer == true) {
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
