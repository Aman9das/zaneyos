{ config, lib, username, ... }:

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
  hardware.sane.enable = true;
  users.users.${username}.extraGroups = ["scanner" "lp"];
}
