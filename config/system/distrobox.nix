{
  config,
  lib,
  pkgs,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/options.nix) distrobox;
in
lib.mkIf (distrobox == true) {
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = with pkgs; [
    pkgs.distrobox
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
}
