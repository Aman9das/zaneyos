{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  home.file.".config/zaney-stinger.mov".source = ./files/media/zaney-stinger.mov;
  home.file.".emoji".source = ./files/emoji;
  home.file.".base16-themes".source = ./files/base16-themes;
  home.file.".face".source = ./files/face.jpg;
  home.file.".config/rofi/rofi.jpg".source = ./files/rofi.jpg;
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
}
