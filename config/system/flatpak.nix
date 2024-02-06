{ config, lib, ... }:

let inherit (import ../../options.nix) flatpak; in
lib.mkIf (flatpak == true) {
  services.flatpak.enable = true;
}
