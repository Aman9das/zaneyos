{ config, lib, pkgs, username, ... }:

let inherit (import ../../options.nix) printer; in
lib.mkIf (printer == true) {
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
    disabledDefaultBackends = ["escl"];
  };
  environment.systemPackages = with pkgs; [ system-config-printer ];
  users.users.${username}.extraGroups = ["scanner" "lp"];
}
