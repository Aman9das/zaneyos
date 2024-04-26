{pkgs, ...}: let
  wallpaper = "$HOME/Pictures/Wallpapers/wall.png";
in {
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf" = {
    text = ''
      preload = ${wallpaper}
      wallpaper = ,${wallpaper}
      splash = false
    '';
  };
}
