{ pkgs, ... }:

let 
  inherit (import ../../options.nix) flakeDir;
in
pkgs.writeShellScriptBin "zcc" ''
  kdenlive=false

  # Function to toggle the boolean variable
  toggle_kdenlive() {
    kdenlive=$(yad --width=200 --height=100 --title="Toggle Kdenlive" \
                   --text="Toggle Kdenlive" --button="Toggle:0" --button="Cancel:1" \
                   --checkbox --value="$kdenlive")

    # If the user clicks "Toggle" button, update the boolean value
    if [ "$?" -eq 0 ]; then
      echo "Kdenlive is now set to: $kdenlive"
    else
      echo "Toggle canceled. Kdenlive remains set to: $kdenlive"
    fi
  }

  # Call the toggle function
  toggle_kdenlive
''
