{ pkgs }:

pkgs.writeShellScriptBin "theme-selector" ''
    # Get user selection for new theme from base16-themes file
    chosen=$(cat $HOME/.base16-themes | ${pkgs.rofi-wayland}/bin/rofi -dmenu)
    
    # Exit if none chosen.
    [ -z "$chosen" ] && exit

    if [ -n "$1" ]; then
	    themechange "$chosen"
    else
	    themechange "$chosen"
	    ${pkgs.libnotify}/bin/notify-send "'$chosen' theme is building this will take a second" &
    fi
''
