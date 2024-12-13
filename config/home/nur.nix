{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ nur.repos.dustinblackman.oatmeal ];
}
