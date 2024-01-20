{ pkgs, }:

pkgs.writeShellScriptBin "swaync-reloader" ''
  ${pkgs.swaynotificationcenter}/bin/swaync-client -R
  ${pkgs.swaynotificationcenter}/bin/swaync-client -rs
''
