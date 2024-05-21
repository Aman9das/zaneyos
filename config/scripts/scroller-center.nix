{pkgs}:
pkgs.writeShellScriptBin "scroller-center" ''
  handle() {
  	if [[ $1 == activewindowv2* ]]; then
  		hyprctl dispatch scroller:alignwindow c
      # hyprctl dispatch movecursor 960 540
  	fi
  }

  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
''
