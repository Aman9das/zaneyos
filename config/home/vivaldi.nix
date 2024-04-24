
{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
  ];
}
