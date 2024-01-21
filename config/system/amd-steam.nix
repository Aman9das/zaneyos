{ pkgs, config, lib, ... }:

lib.mkIf ("${deviceProfile}" == "amd-desktop") {
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override { withJava = true; };
  };
}
