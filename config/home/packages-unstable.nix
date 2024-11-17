{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  inputs,
  host,
  ...
}:

{
  home.packages = with pkgs-unstable; [ sioyek ];
}
