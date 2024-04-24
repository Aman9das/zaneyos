{ pkgs, config, lib, ... }:
with pkgs;
let
 rpkgs = rWrapper.override {
   packages = with rPackages; [
    tidyverse
    quarto
    MASS
    quarto
    ISLR2
    GGally
   ];
 };
 in
{
  # R
  environment.systemPackages = with pkgs; [
    rpkgs
    quarto
  ];

  environment.variables = rec {
      QUARTO_R = "${rpkgs}/bin/R";
  };
}
