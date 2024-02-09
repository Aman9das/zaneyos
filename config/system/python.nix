{ pkgs, config, lib, ... }:

let
  inherit (import ../../options.nix) python;
in lib.mkIf (python == true) {
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-community-bin
    (pkgs.python3.withPackages my-python-packages)
  ];

}
