{pkgs}:
pkgs.writeShellScriptBin "rofi-exit" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi

  # CMDs
  uptime="$(uptime | sed -E 's/.*up[[:space:]]*([^,[:space:]]+).*/\1/')"
  host=$(hostname)

  # Options
  shutdown=' Shutdown'
  reboot=' Reboot'
  lock=' Lock'
  suspend=' Suspend'
  logout=' Logout'
  hibernate=' Hibernate'
  yes=' Yes'
  no=' No'

  # Rofi CMD
  rofi_cmd() {
  	rofi -dmenu \
  		-p "$host" \
  		-mesg "Uptime: $uptime"
  }

  # Confirmation CMD
  confirm_cmd() {
  	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false;}' \
  		-dmenu \
  		-p 'Confirmation' \
  		-mesg 'Are you Sure?'
  }

  # Ask for confirmation
  confirm_exit() {
  	echo -e "$yes\n$no" | confirm_cmd
  }

  # Pass variables to rofi dmenu
  run_rofi() {
  	echo -e "$lock\n$suspend\n$hibernate\n$logout\n$reboot\n$shutdown" | rofi_cmd
  }

  # Execute Command
  run_cmd() {
  	selected="$(confirm_exit)"
  	if [[ "$selected" == "$yes" ]]; then
  		if [[ $1 == '--shutdown' ]]; then
        exit_apps
  			sleep 0.1 && systemctl poweroff
  		elif [[ $1 == '--reboot' ]]; then
        exit_apps
  			sleep 0.1 && systemctl reboot
  		elif [[ $1 == '--hibernate' ]]; then
  			sleep 0.1 && systemctl hibernate
  		elif [[ $1 == '--suspend' ]]; then
  			sleep 0.1 && systemctl suspend
  		elif [[ $1 == '--logout' ]]; then
        exit_apps
  			sleep 0.1 && hyprctl dispatch exit
  		fi
  	else
  		exit 0
  	fi
  }

  # Actions
  chosen="$(run_rofi)"
  case $chosen in
  $shutdown)
  	run_cmd --shutdown
  	;;
  $reboot)
  	run_cmd --reboot
  	;;
  $lock)
    sleep 0.1 && hyprlock
  	;;
  $hibernate)
  	run_cmd --hibernate
  	;;
  $suspend)
  	run_cmd --suspend
  	;;
  $logout)
  	run_cmd --logout
  	;;
  esac
''
