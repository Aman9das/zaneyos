{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      widevine-cdm = widevine-cdm;
      vivaldi-ffmpeg-codecs = vivaldi-ffmpeg-codecs;
    })
  ];
  home.sessionVariables = {
    BROWSER = "vivaldi";
  };
}
