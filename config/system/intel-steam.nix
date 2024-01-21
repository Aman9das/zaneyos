{ pkgs, config, lib, deviceProfile, ... }:

lib.mkIf ("${deviceProfile}" == "intel-laptop") {
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      withPrimus = true;
      extraPkgs = pkgs: [ pkgs.bumblebee pkgs.glxinfo ];
    };
  };
}
