{ pkgs, config, lib, ... }:

lib.mkIf ("${deviceProfile}" == "intel-laptop") {
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      withPrimus = true;
      withJava = true;
      extraPkgs = pkgs: [ bumblebee glxinfo ];
    };
  };
}
