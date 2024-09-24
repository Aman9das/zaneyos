{
  config,
  lib,
  pkgs,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/options.nix) theKernel;
in
{
  boot.kernelPackages = lib.mkDefault pkgs.${theKernel};
}
