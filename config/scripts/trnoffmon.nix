{ pkgs, ... }:

pkgs.writeShellScriptBin "trnoffmon" ''
  # IDLECOMMAND=$(swayidle -w timeout 5 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on')

  # while :
  # do
  # done

  # if [ $SWAYIDLESTATE == 1 ]; then
  #   export SWAYIDLESTATE=2
  #   pkill swayidle
  # else
  #   IDLESTATE=true
  #   $IDLECOMMAND
  # fi  
  # pkill swayidle
  # IDLESTATE=true
  # $IDLECOMMAND
''
