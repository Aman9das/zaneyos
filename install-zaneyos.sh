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
    exit 1
fi

echo "-----"

echo "Ensure In Home Directory"
cd

echo "-----"

# Check For Persistence. Backing up current flake files
# with it enabled is not yet implemented.
persistState=$(cat zaneyos/hardware.nix | grep persistence | wc -l)
if [ $persistState -eq 0 ]; then
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
fi

echo "-----"

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Cloning & Entering ZaneyOS Repository"
git clone https://gitlab.com/zaney/zaneyos.git
cd zaneyos

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
sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$userName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Hostname: [ hyprnix ] " hostName
if [ -z "$hostName" ]; then
  hostName="hyprnix"
fi
sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Username: [ John Smith ] " gitUserName
if [ -z "$gitUserName" ]; then
  gitUserName="John Smith"
fi
sed -i "/^\s*gitUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitUserName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Email: [ johnsmith@gmail.com ] " gitEmail
if [ -z "$gitEmail" ]; then
  gitEmail="johnsmith@gmail.com"
fi
sed -i "/^\s*gitEmail[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitEmail\"/" ./options.nix

echo "-----"

read -p "Enter Your Locale: [ en_US.UTF-8 ] " locale
if [ -z "$locale" ]; then
  locale="en_US.UTF-8"
fi
sed -i "/^\s*theLocale[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$locale\"/" ./options.nix

echo "-----"

read -p "Enter Your Keyboard Layout: [ us ] " kbdLayout
if [ -z "$kbdLayout" ]; then
  kbdLayout="us"
fi
sed -i "/^\s*theKBDLayout[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$kbdLayout\"/" ./options.nix

echo "-----"

read -p "Enter Your Timezone: [ America/New_York ] " timezone
if [ -z "$timezone" ]; then
  timezone="America/New_York"
fi
escaped_timezone=$(echo "$timezone" | sed 's/\//\\\//g')
sed -i "/^\s*theTimezone[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_timezone\"#" ./options.nix

echo "-----"

read -p "Set 24 Hour Clock: [ false ] " clockFormat
user_input_lower=$(echo "$clockFormat" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    clockFormat="true"
    ;;
  *)
    clockFormat="false"
    ;;
esac
sed -i "/^\s*clock24h[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$clockFormat\"/" ./options.nix

echo "-----"

read -p "Enable Animated Borders: [ false ] " animBorder
user_input_lower=$(echo "$animBorder" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    animBorder="true"
    ;;
  *)
    animBorder="false"
    ;;
esac
sed -i "/^\s*borderAnim[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$animBorder\"/" ./options.nix

echo "-----"

read -p "Extra Logitech Device Support: [ false ] " logitechSupport
user_input_lower=$(echo "$logitechSupport" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    logitechSupport="true"
    ;;
  *)
    logitechSupport="false"
    ;;
esac
sed -i "/^\s*logitech[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$logitechSupport\"/" ./options.nix

echo "-----"

read -p "Install Kdenlive: [ false ] " kdenlive
user_input_lower=$(echo "$kdenlive" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    kdenlive="true"
    ;;
  *)
    kdenlive="false"
    ;;
esac
sed -i "/^\s*kdenlive[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$kdenlive\"/" ./options.nix

echo "-----"

read -p "Install Zero AD Game: [ false ] " enableZeroAD
user_input_lower=$(echo "$enableZeroAD" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    zeroad="true"
    ;;
  *)
    zeroad="false"
    ;;
esac
sed -i "/^\s*enableZeroAD[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$zeroad\"/" ./options.nix

echo "-----"

read -p "Install Syncthing: [ false ] " enableSyncthing
user_input_lower=$(echo "$enableSyncthing" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    enableSyncthing="true"
    ;;
  *)
    enableSyncthing="false"
    ;;
esac
sed -i "/^\s*syncthing[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$enableSyncthing\"/" ./options.nix

echo "-----"

read -p "Enable Printer Support: [ false ] " printers
user_input_lower=$(echo "$printers" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    printers="true"
    ;;
  *)
    printers="false"
    ;;
esac
sed -i "/^\s*printer[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$printers\"/" ./options.nix

echo "-----"

read -p "Enable Flatpak Support: [ false ] " flatpaks
user_input_lower=$(echo "$printers" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    printers="true"
    ;;
  *)
    printers="false"
    ;;
esac
sed -i "/^\s*flatpak[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$flatpaks\"/" ./options.nix

echo "-----"

read -p "Enable Python & Pycharm Support: [ false ] " pythonEnable
user_input_lower=$(echo "$pythonEnable" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    pythonEnable="true"
    ;;
  *)
    pythonEnable="false"
    ;;
esac
sed -i "/^\s*python[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$pythonEnable\"/" ./options.nix

echo "-----"

echo "Valid options include amd, intel, and vm"
read -p "Enter Your CPU Type: [ intel ] " cpuType
user_input_lower=$(echo "$cpuType" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  amd)
    cpuType="amd"
    ;;
  intel)
    cpuType="intel"
    ;;
  vm)
    cpuType="vm"
    ;;
  *)
    echo "Option Entered Not Available, Falling Back To [ intel ] Option."
    sleep 1
    cpuType="intel"
    ;;
esac
sed -i "/^\s*cpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$cpuType\"/" ./options.nix

echo "-----"

echo "Valid options include amd, intel, nvidia, vm, intel-nvidia"
read -p "Enter Your GPU Type : " gpuType
user_input_lower=$(echo "$gpuType" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  amd)
    gpuType="amd"
    ;;
  intel)
    gpuType="intel"
    ;;
  vm)
    gpuType="vm"
    ;;
  nvidia)
    gpuType="nvidia"
    ;;
  intel-nvidia)
    gpuType="intel-nvidia"
    ;;
  *)
    echo "Option Entered Not Available, Falling Back To [ intel ] Option."
    sleep 1
    gpuType="intel"
    ;;
esac
sed -i "/^\s*gpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gpuType\"/" ./options.nix

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > hardware.nix

echo "-----"

echo "Now Going To Build ZaneyOS, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#$hostName

if [ $userName != $installusername ]; then
  cd
  cp -r zaneyos /home/$userName/
  sudo chown -R $userName:users /home/$userName/zaneyos
  echo "Ensuring ZaneyOS repository is in your users HOME directory."
fi

echo "-----"

echo "ZaneyOS Has Been Installed!"
echo "Please use responsibly."
