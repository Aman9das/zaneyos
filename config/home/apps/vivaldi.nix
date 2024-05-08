{ pkgs, pkgs-stable, config, lib, ... }:
{
  home.packages = with pkgs-stable; [
    (vivaldi.override {
      proprietaryCodecs = true;
      vivaldi-ffmpeg-codecs = vivaldi-ffmpeg-codecs;
    })
  ];
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
