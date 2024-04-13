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

read -p "Enter Your New Git Username: [ John Smith ] " gitUserName
if [ -z "$gitUserName" ]; then
  gitUserName="John Smith"
fi
sed -i "/^\s*gitUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitUserName\"/" ./hosts/$hostName/options.nix

echo "-----"

read -p "Enter Your New Git Email: [ johnsmith@gmail.com ] " gitEmail
if [ -z "$gitEmail" ]; then
  gitEmail="johnsmith@gmail.com"
fi
sed -i "/^\s*gitEmail[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitEmail\"/" ./hosts/$hostName/options.nix

echo "-----"

read -p "Enter Your Locale: [ en_US.UTF-8 ] " locale
if [ -z "$locale" ]; then
  locale="en_US.UTF-8"
fi
sed -i "/^\s*theLocale[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$locale\"/" ./hosts/$hostName/options.nix

echo "-----"

read -p "Enter Your Keyboard Layout: [ us ] " kbdLayout
if [ -z "$kbdLayout" ]; then
  kbdLayout="us"
fi
sed -i "/^\s*theKBDLayout[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$kbdLayout\"/" ./hosts/$hostName/options.nix

echo "-----"

read -p "Enter Your Timezone: [ America/New_York ] " timezone
if [ -z "$timezone" ]; then
  timezone="America/New_York"
fi
escaped_timezone=$(echo "$timezone" | sed 's/\//\\\//g')
sed -i "/^\s*theTimezone[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_timezone\"#" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Set 24 Hour Clock: [ false ] " clockFormat
if [ -z "$clockFormat" ]; then
  clockFormat="false"
fi
sed -i "/^\s*clock24h[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$clockFormat\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Enable Animated Borders: [ false ] " animBorder
if [ -z "$animBorder" ]; then
  animBorder="false"
fi
sed -i "/^\s*borderAnim[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$animBorder\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Extra Logitech Device Support: [ false ] " logitechSupport
if [ -z "$logitechSupport" ]; then
  logitechSupport="false"
fi
sed -i "/^\s*logitech[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$logitechSupport\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Install Kdenlive: [ false ] " kdenlive
if [ -z "$kdenlive" ]; then
  kdenlive="false"
fi
sed -i "/^\s*kdenlive[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$kdenlive\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Install Zero AD Game: [ false ] " enableZeroAD
if [ -z "$enableZeroAD" ]; then
  enableZeroAD="false"
fi
sed -i "/^\s*enableZeroAD[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$enableZeroAD\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Install Syncthing: [ false ] " enableSyncthing
if [ -z "$enableSyncthing" ]; then
  enableSyncthing="false"
fi
sed -i "/^\s*syncthing[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$enableSyncthing\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Enable Printer Support: [ false ] " printers
if [ -z "$printers" ]; then
  printers="false"
fi
sed -i "/^\s*printer[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$printers\"/" ./hosts/$hostName/options.nix

echo "-----"

echo "Must be true or false."
echo "Please check spelling before pressing Enter!"
read -p "Enable Flatpak Support: [ false ] " flatpaks
if [ -z "$flatpaks" ]; then
  flatpaks="false"
fi
sed -i "/^\s*flatpak[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$flatpaks\"/" ./hosts/$hostName/options.nix

echo "-----"

read -p "Enable Python & Pycharm Support: [ false ] " pythonEnable
if [ -z "$pythonEnable" ]; then
  pythonEnable="false"
fi
user_input_lower=$(echo "$pythonEnable" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    pythonEnable="true"
    ;;
  *)
    pythonEnable="false"
    ;;
esac
sed -i "/^\s*python[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$pythonEnable\"/" ./hosts/$hostName/options.nix

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
sed -i "/^\s*cpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$cpuType\"/" ./hosts/$hostName/options.nix

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
sed -i "/^\s*gpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gpuType\"/" ./hosts/$hostName/options.nix

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

echo "-----"

echo "Now Going To Build ZaneyOS, 🤞"
git commit -am "Add new hosts folder and all the new settings"
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

echo "-----"

echo "System is now going to reboot"
# sleep 2
# systemctl reboot
