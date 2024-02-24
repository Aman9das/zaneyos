{ pkgs, username }:

pkgs.writeShellScriptBin "logout-sys" ''
  sleep 1
  killall -9 Hyprland sleep 2
''
