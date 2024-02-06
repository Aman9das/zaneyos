{ config, lib, ... }:

let inherit (import ../../options.nix) flatpak; in
lib.mkIf ("${flatpak}" == "on") {
  services.flatpak.enable = true;
}
