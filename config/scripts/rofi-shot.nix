{pkgs}:
pkgs.writeShellScriptBin "rofi-shot" ''
  # Kill if any other rofi instance is running
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi

  # Set screenshot directory
  SCREENSHOT_DIR="$HOME/pictures/Screenshots/"
  if [[ ! -d $SCREENSHOT_DIR ]]
  then
    mkdir -p "$SCREENSHOT_DIR"
  fi

  # Set filename
  FILENAME="$SCREENSHOT_DIR/$(date +%Y-%m-%d-T-%H-%M-%S).png"


  screen='  Capture screen'
  area='  Capture area'
  window='  Capture current window'

  chosen=$(printf '%s\n%s\n%s\n' "$screen" "$area" "$window" \
          | rofi -dmenu -l 3 -p "Screenshot:"\
      )

  case "$chosen" in
      "$screen") extra_args='output' ;;
      "$area")   extra_args='area' ;;
      "$window") extra_args='active' ;;
      *)         exit 1 ;;
  esac

  # sleep 0.5 && grimblast copysave $extra_args $FILENAME && notify-send "🖼️ Screenshot taken and saved"
  sleep 0.5 && grimblast --freeze --notify copysave $extra_args $FILENAME
''
