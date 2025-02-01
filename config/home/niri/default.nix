{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit

    xwayland-satellite

    gammastep
  ];
}
