{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.kdenlive
    mlt
    glaxnimate
  ];
}
