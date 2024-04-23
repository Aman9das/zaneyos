{ pkgs, config, lib, ... }:
with pkgs;
let
  R-with-my-packages = rWrapper.override{ packages = with rPackages; [
    ggplot2 dplyr tidyverse
    ISLR2
    MASS
  ]; };
in
{
  # R
  environment.systemPackages = with pkgs; [
    R-with-my-packages
    quarto
  ];
}
