{ pkgs, config, lib, cpuType, ... }:

{
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = lib.mkIf ("${cpuType}" == "intel") {
      pkgs.steam.override = {
        withPrimus = true;
        extraPkgs = [ pkgs.bumblebee pkgs.glxinfo ];
      };
    };
  };
}
