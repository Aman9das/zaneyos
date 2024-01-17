{ pkgs, flakeDir, }:

pkgs.writeShellScriptBin "themechange" ''
    if [[ ! $@ ]];then
        echo "No Theme Given"
    else
        replacement="$1"
        sed -i "/^\s*theme[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$replacement\"/" ${flakeDir}/flake.nix
        sudo nixos-rebuild switch --flake ${flakeDir}/#workstation
        ${pkgs.toybox}/bin/pkill ${pkgs.swaynotificationcenter}/bin/swaync
        ${pkgs.toybox}/bin/nohup ${pkgs.swaynotificationcenter}/bin/swaync &
        rm nohup.out
    fi
''
