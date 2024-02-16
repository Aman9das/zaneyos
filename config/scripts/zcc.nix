{ pkgs, ... }:

let 
  inherit (import ../../options.nix) flakeDir flakePrev flakeBackup;
in
pkgs.writeShellScriptBin "zcc" ''
  if [ "$#" -eq 0 ]; then
    echo "The ZaneyOS Control Center requires an option like 'zcc [OPTION]'."
  elif [ "$#" -eq 1 ]; then
    if [ "$ZANEYOS" = true ]; then
      choice="$1"
      if [[ "$choice" = "update" ]]; then
	# Add your update logic here
	# If ~/zaneyos-previous exists, backup the configuration
	if [[ -d ${flakePrev} ]]; then
	  # Check if ~/zaneyos-backup exists, otherwise create it
	  if [[ ! -d ${flakeBackup} ]]; then
	    mkdir ${flakeBackup}
	  fi

	  # Create a unique backup folder name with date and time
	  backup_folder=${flakeBackup}/$(date +"%Y%m%d%H%M%S")

	  # Backup previous configuration
	  sudo mv ${flakePrev} "$backup_folder"
	  echo "---"
	  echo "Previous configuration saved in $backup_folder"
	fi
	# Copy the previous repository
	sudo cp -rp ${flakeDir} ${flakePrev}
	echo "---"
	echo "Actual configuration saved on $FLAKEPREV"

	# Change directory
	cd ${flakeDir} || exit 1

	# Run git status to get only modified, tracked but not committed files
	files_to_check=$(git status -s --untracked-files=no | awk '{print $2}')

	# Stash changes and update the local repo from the remote one
	echo "---"
	echo "Updating zaneyos..."
	git stash && git pull

	# Show files to check to the user
	echo "---"
	echo "Files to review:"
	echo $files_to_check

	# Initialize the unresolved_files list
	unresolved_files=()

	# Verify and overwrite files if the user confirms or save files to be manually reviewed
	for file in $files_to_check; do
	  echo "---"
	  echo "Differences on $file:"
	  diff "$file" ~/zaneyos-previous/"$file"
	  echo "---"
	  read -p "Overwrite file $file with your? [Y/n]: " choice
	  case "$choice" in
	  *)
            cp ~/zaneyos-previous/"$file" "$file"
            ;;
	  n|N)
            # Add the file to unresolved_files
            unresolved_files+=("$file")
            ;;
	  esac
	done

	# If unresolved_files contains one or more files
	if [[ ''${#unresolved_files[@]} -gt 0 ]]; then
	  # Show the user files to be manually reviewed and exit
	  echo "---"
	  echo "Review manually the following files:"
	  printf '%s\n' "''${unresolved_files[@]}"
	else
	  # Prompt for updating flake.nix
	  echo "---"
	  read -p "Do you want to update flake? [Y/n]: " update_flake
	  update_flake=${update_flake:-Y}  # Set Y as default option
	  if [[ $update_flake == [Yy] ]]; then
	    # Run flake-update
	    echo "---"
	    echo "Running flake-update..."
	    sudo nix flake update ~/zaneyos
	    # Prompt for system rebuild
	    echo "---"
	    read -p "Do you want to rebuild the system? [Y/n]: " rebuild_system
	    rebuild_system=${rebuild_system:-Y}  # Set Y as default option
	    if [[ $rebuild_system == [Yy] ]]; then
	      # Run flake-rebuild
	      echo "---"
	      echo "Running flake-rebuild..."
	      sudo nixos-rebuild switch --flake ~/zaneyos
	    else
	      echo "---"
	      echo "Ok, the system will not be rebuilt"
	    fi
	  else
	    echo "---"
	    echo "Ok, flake will not be updated"
	  fi
	fi
	echo "---"
	echo "Ok. Press any key to exit."
	read -n 1 -s

      elif [[ "$choice" = "install" ]]; then
	echo "Installing..."
	# Add logic for when the user chooses not to update
      else
	echo "Invalid option. Try zcc update or zcc install"
      fi
    else
      echo "ZANEYOS is false"
    fi
  else
    echo "Too many arguments. Please provide one argument."
  fi
''
