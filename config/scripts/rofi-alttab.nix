{ pkgs }:
pkgs.writeShellScriptBin "rofi-alttab" ''
  #!/bin/bash

  # Check if rofi is running
  if pgrep -x "rofi" > /dev/null; then
      # Rofi is running, execute the ydotool command
      ydotool key 108:1 108:0
  else
      # Rofi is not running, start rofi in window mode
      rofi -show window -kb-cancel "Alt+Escape,Escape" -timeout-delay 0.5 -timeout-action "kb-accept-entry" -kb-element-next "Alt+Tab,Alt+Down" -kb-element-prev "Alt+Up,Alt+Shift+Tab"
  fi
''
