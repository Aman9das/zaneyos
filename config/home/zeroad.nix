{ pkgs, config, lib, ... }:

let inherit (import ../../options.nix) enableZeroAD; in
lib.mkIf (enableZeroAD == true) {
  home.packages = with pkgs; [
    zeroad
  ];
}
