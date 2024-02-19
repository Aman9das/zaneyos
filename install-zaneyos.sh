#!/usr/bin/env bash

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "This is NixOS."
    echo "Continuing with the ZaneyOS installation."
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

cd
echo "Cloning & Entering ZaneyOS Repository"
git clone https://gitlab.com/zaney/zaneyos.git
cd zaneyos

echo "-----"

read -p "Enter Your New Username: " userName
sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$userName\"/" ./options.nix

echo "The password for a new user is password"
sleep 2

echo "-----"

read -p "Enter Your New Hostname: " hostName
sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Username [Can Be Full Name]: " gitUserName
sed -i "/^\s*gitUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitUserName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Email: " gitEmail
sed -i "/^\s*gitEmail[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitEmail\"/" ./options.nix

echo "-----"

read -p "Enter Your Locale, Example> en_US.UTF-8 : " locale
sed -i "/^\s*theLocale[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$locale\"/" ./options.nix

echo "-----"

read -p "Enter Your Keyboard Layout, Example> us : " kbdLayout
sed -i "/^\s*theKBDLayout[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$kbdLayout\"/" ./options.nix

echo "-----"

read -p "Enter Your Timezone, Example> America/New_York : " timezone
escaped_timezone=$(echo "$timezone" | sed 's/\//\\\//g')
sed -i "/^\s*theTimezone[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_timezone\"#" ./options.nix

echo "-----"

echo "Valid options include amd, intel, and vm"
read -p "Enter Your CPU Type : " cpuType
sed -i "/^\s*cpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$cpuType\"/" ./options.nix

echo "-----"

echo "Valid options include amd, intel, nvidia, vm, intel-nvidia"
read -p "Enter Your GPU Type : " gpuType
sed -i "/^\s*gpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gpuType\"/" ./options.nix

echo "Generating The Hardware Configuration"
nixos-generate-config --show-hardware-config > hardware.nix

echo "-----"

echo "Now Going To Build ZaneyOS, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#$hostName
