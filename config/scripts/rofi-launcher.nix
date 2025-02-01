{ pkgs }:
pkgs.writeShellScriptBin "rofi-launcher" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    # pkill -x rofi
    # exit 0
    # Rofi is running, execute the ydotool command
    ydotool key 29:1 15:1 15:0 29:0

  else
    rofi -show drun
  fi
''
