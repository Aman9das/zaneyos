{ pkgs, ... }:

pkgs.writeShellScriptBin "idle-switcher" ''
  IDLECOMMAND=$(swayidle -w timeout 5 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on')

  if [ $SWAYIDLESTATE == "1" ]; then
    SWAYIDLESTATE="2"
    notify-send -t 2500 "Killing SwayIdle Sir."
    killall swayidle
  else
    SWAYIDLESTATE="1"
    notify-send -t 2500 "Starting SwayIdle Sir."
    $IDLECOMMAND
  fi  
''
