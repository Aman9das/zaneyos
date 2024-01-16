{ pkgs }:

pkgs.writeShellScriptBin "wallsetter" ''
TIMEOUT=5
OSRELEASE=$(cat /etc/os-release | grep nixos | shuf -n 1)
FILETYPE="l"
TRANSITION1="--transition-type wave --transition-angle 120 --transition-step 30"
TRANSITION2="--transition-type wipe --transition-angle 30 --transition-step 30"
TRANSITION3="--transition-type center --transition-step 30"
TRANSITION4="--transition-type outer --transition-pos 0.3,0.8 --transition-step 30"
TRANSITION5="--transition-type wipe --transition-angle 270 --transition-step 30"

[[ ! -z "$testvar" ]] && FILETYPE="l" || FILETYPE="f"
WALLPAPER=$(find $HOME/Pictures/Wallpapers -type $FILETYPE | shuf -n 1)
PREVIOUS=$WALLPAPER

while true;
do
    if [ $WALLPAPER == $PREVIOUS ]
    then
        WALLPAPER=$(find $HOME/Pictures/Wallpapers -type $FILETYPE | shuf -n 1)
    else
        PREVIOUS=$WALLPAPER
        NUM=$(shuf -i 1-5 -n 1)
        case $NUM in
            1)
                TRANSITION=$TRANSITION1
            ;;
            2)
                TRANSITION=$TRANSITION2
            ;;
            3)
                TRANSITION=$TRANSITION3
            ;;
            4)
                TRANSITION=$TRANSITION4
            ;;
            5)
                TRANSITION=$TRANSITION5
            ;;
        esac
        ${pkgs.swww}/bin/swww img $WALLPAPER $TRANSITION
        sleep $TIMEOUT
    fi
done
''
