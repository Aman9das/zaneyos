{pkgs}:
pkgs.writeShellScriptBin "scroller-fitsize" ''
  handle() {
    case $1 in
      activewindowv2*)
  		hyprctl --batch "dispatch scroller:setmode col; dispatch scroller:fitsize all; dispatch scroller:setmode row" ;;
      movewindowv2*)
  		hyprctl --batch "dispatch scroller:setmode col; dispatch scroller:fitsize all; dispatch scroller:setmode row" ;;
      workspacev2*)
  		hyprctl --batch "dispatch scroller:setmode col; dispatch scroller:fitsize all; dispatch scroller:setmode row" ;;
    esac
  }

  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
''
