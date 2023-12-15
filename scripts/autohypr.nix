{ pkgs }:

pkgs.writeShellScriptBin "autohypr" ''
    ${pkgs.swww}/bin/swww init &
    ${pkgs.swaynotificationcenter}/bin/swaync &
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.xfce.thunar}/bin/thunar --daemon &
    ${pkgs.swww}/bin/swww img ~/.config/wallpaper.png &
''
