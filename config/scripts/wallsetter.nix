{ pkgs }:

pkgs.writeShellScriptBin "wallsetter" ''
    NEWWALLPAPER=$(find $HOME/Pictures/Wallpapers -type l | shuf -n 1)

    ${pkgs.swww}/bin/swww img $NEWWALLPAPER --transition-type wave --transition-angle 120 --transition-step 30
''
