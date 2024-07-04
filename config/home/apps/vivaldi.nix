{
  system,
  pkgs,
  pkgs-stable,
  config,
  lib,
  ...
}:
let
  pkgs-may =
    import
      (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify
        name = "april-revision-nixpkgs-unstable";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/nixpkgs-unstable";
        rev = "e2dd4e18cc1c7314e24154331bae07df76eb582f";
      })
      {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
in
{
  home.packages = with pkgs; [
    vivaldi
    uget
    uget-integrator
  ];
}
