#!/usr/bin/env bash

# Add & Update Home Manager Channel
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update

sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/home.nix
sudo rm -rf /etc/configfiles
sudo rm -rf /etc/scripts

sudo cp nixos/configuration.nix /etc/nixos/
sudo cp nixos/home.nix /etc/nixos/

sudo cp -r configfiles/ /etc/
sudo cp -r scripts/ /etc/

sudo nixos-rebuild switch
