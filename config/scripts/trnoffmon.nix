{ config, pkgs, ... }:

pkgs.writeShellScriptBin "trnoffmon" ''
  if [[ ! $@ ]]; then
    pkill swayidle
  else
    swayidle -w timeout 5 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
  fi
''
