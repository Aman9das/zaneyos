{ pkgs, ... }:

pkgs.writeShellScriptBin "idle-switcher" ''
  IDLECOMMAND=$(swayidle -w timeout 5 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on')

  if [[ ! $@ ]]; then
    notify-send -t 2500 "Killing SwayIdle Sir."
    killall swayidle
  else
    notify-send -t 2500 "Starting SwayIdle Sir."
    $IDLECOMMAND
  fi  
''
