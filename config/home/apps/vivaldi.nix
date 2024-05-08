{ system, pkgs, pkgs-stable, config, lib, ... }:
let
     pkgs-april = import (builtins.fetchGit {
         # Descriptive name to make the store path easier to identify
         name = "april-revision-nixpkgs-unstable";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixpkgs-unstable";
         rev = "e89cf1c932006531f454de7d652163a9a5c86668";
     }) {
      inherit system;
      config = {
          allowUnfree = true;
        };
      };

in
{
  home.packages = [
    (pkgs-april.vivaldi.override {
        proprietaryCodecs = true;
      })
  ];
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
