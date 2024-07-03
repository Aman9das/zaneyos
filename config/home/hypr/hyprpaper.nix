{ pkgs, ... }:
let
  wallpaper = "$HOME/.config/wallpaper/wall.jpeg";
in
{
  home.packages = with pkgs; [ hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf" = {
    text = ''
      preload = ${wallpaper}
      wallpaper = ,${wallpaper}
      splash = false
    '';
  };
}
