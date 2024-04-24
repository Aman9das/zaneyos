{ pkgs, config, lib, ... }:
with pkgs;
let
  rpkgs = with rPackages; [
    tidyverse
    quarto
    MASS
    quarto
    ISLR2
    GGally
  ];
  r-set = rWrapper.override { packages = rpkgs; };
  rstudio-set = rstudioWrapper.override{ packages = rpkgs; };
  radian-set = radianWrapper.override{ packages = rpkgs; };
 in
{
  # R
  home.packages = with pkgs; [
    r-set rstudio-set radian-set
    quarto
  ];

  home.sessionVariables = rec {
      QUARTO_R = "${r-set}/bin/R";
  };
}
