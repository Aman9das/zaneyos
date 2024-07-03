{ pkgs, ... }:
{
  home.packages = with pkgs; [ openshot-qt ];
}
