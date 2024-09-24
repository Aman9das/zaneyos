{
  pkgs,
  config,
  lib,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/options.nix) python;
  my-python-packages =
    ps: with ps; [
      pandas
      requests
      ipython
      pip
      virtualenv
    ];
in
lib.mkIf (python == true) {
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-community-bin
    (pkgs.python3.withPackages my-python-packages)
  ];
}
