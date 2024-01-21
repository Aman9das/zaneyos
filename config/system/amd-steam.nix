{ pkgs, config, lib, deviceProfile, ... }:

lib.mkIf ("${deviceProfile}" == "amd-desktop") {
  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
