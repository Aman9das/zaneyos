{ pkgs, flakeDir, }:

pkgs.writeShellScriptBin "themechange" ''
    if [[ ! $@ ]];then
        echo "No Theme Given"
    else
        replacement="$1"
        sed -i "/^\s*theme[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$replacement\"/" ${flakeDir}/flake.nix
        pkexec nixos-rebuild switch --flake ${flakeDir}
        ${pkgs.swaynotificationcenter}/bin/swaync-client -R &
        ${pkgs.swaynotificationcenter}/bin/swaync-client -rs &
    fi
''
