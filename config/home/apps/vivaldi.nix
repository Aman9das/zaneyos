{
  system,
  pkgs,
  pkgs-stable,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    vivaldi
    uget
    uget-integrator
  ];
}
