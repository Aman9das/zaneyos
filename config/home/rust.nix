{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    cargo
    rustc
  ];
}
