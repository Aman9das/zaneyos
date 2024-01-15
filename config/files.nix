{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  home.file.".config/zaney-stinger.mov".source = ./media/zaney-stinger.mov;
  home.file.".emoji".source = ./config/files/emoji;
  home.file.".face".source = ./config/files/face.jpg;
  home.file.".config/pipewire/pipewire.conf".source = ./config/pipewire/pipewire.conf;
  home.file."Pictures/Wallpapers" = {
    source = ./media/Wallpapers;
    recursive = true;
  };
  home.file.".local/share/fonts" = {
    source = ./fonts;
    recursive = true;
  };
  home.file.".config/swaync" = {
    source = ./config/swaync;
    recursive = true;
  };
