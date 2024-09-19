{
  system,
  pkgs,
  pkgs-stable,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ zoom-us ];
}
