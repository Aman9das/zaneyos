#!/usr/bin/env bash

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "Verified this is NixOS."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available."
    exit
fi

if command -v git &> /dev/null; then
    echo "Git is installed, continuing with installation."
else
    echo "Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit
fi

echo "-----"

echo "Ensure In Home Directory"
cd

echo "-----"

read -p "Enter Your New Hostname: [ hyprnix ] " hostName
if [ -z "$hostName" ]; then
  hostName="hyprnix"
fi

echo "-----"

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "zaneyos" ]; then
  echo "ZaneyOS exists, backing up to .config/zaneyos-backups folder."
  if [ -d ".config/zaneyos-backups" ]; then
    echo "Moving current version of ZaneyOS to backups folder."
    mv $HOME/zaneyos .config/zaneyos-backups/$backupname
    sleep 1
  else
    echo "Creating the backups folder & moving ZaneyOS to it."
    mkdir -p .config/zaneyos-backups
    mv $HOME/zaneyos .config/zaneyos-backups/$backupname
    sleep 1
  fi
else
  echo "Thank you for choosing ZaneyOS."
  echo "I hope you find your time here enjoyable!"
fi

echo "-----"

echo "Cloning & Entering ZaneyOS Repository"
git clone https://gitlab.com/zaney/zaneyos.git
cd zaneyos
mkdir hosts/$hostName
cp hosts/default/*.nix hosts/$hostName
git add .
sed -i "/^\s*setHostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./hosts/$hostName/options.nix
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix

echo "-----"

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

installusername=$(echo $USER)
read -p "Enter Your Username: [ $installusername ] " userName
if [ -z "$userName" ]; then
  userName=$(echo $USER)
else
  if [ $installusername != $userName ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      read -s -p "Enter New User Password: " newPass
      read -s -p "Enter New User Password Again: " newPass2
      if [ $newPass == $newPass2 ]; then
	echo "Passwords Match. Setting password."
	userPassword=$(mkpasswd -m sha-512 $newPass)
	escaped_userPassword=$(echo "$userPassword" | sed 's/\//\\\//g')
	sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_userPassword\"#" ./system.nix
	break
      fi
    done
  fi
fi
sed -i "/^\s*setUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$userName\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

echo "-----"

echo "Setting Required Nix Settings & Committing Changes"
git add .
git commit -am "Add new hosts folder and all the new settings"
NIX_CONFIG="experimental-features = nix-command flakes"

if [ $userName != $installusername ]; then
  cd
  cp -r zaneyos /home/$userName/
  sudo chown -R $userName:users /home/$userName/zaneyos
  echo "Ensuring ZaneyOS repository is in your users HOME directory."
fi

echo "-----"

echo "ZaneyOS Has Been Setup"
echo "Make Sure To Change Your Options In hosts/<yourhostname>"
echo "To Install Run: sudo nixos-rebuild switch --flake .#<yourhostname>"