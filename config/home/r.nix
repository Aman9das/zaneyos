{ pkgs, config, lib, ... }:
with pkgs;
let
  rpkgs = with rPackages; [
    tidyverse
    quarto tinytex
    MASS zoo slider
    GGally readODS
    ISLR2
    languageserversetup languageserver
  ];
  r-set = rWrapper.override { packages = rpkgs; };
  rstudio-set = rstudioWrapper.override{ packages = rpkgs; };
  radian-set = radianWrapper.override{ packages = rpkgs; };
  quarto-set = quarto.override{ extraRPackages = rpkgs; };
 in
{
  # R
  home.packages = with pkgs; [
    r-set rstudio-set radian-set
    quarto-set
    texliveFull
  ];
}
