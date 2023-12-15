#!/usr/bin/env bash

sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/home.nix
sudo rm -rf /etc/configfiles
sudo rm -rf /etc/scripts

sudo cp nixos/configuration.nix /etc/nixos/
sudo cp nixos/home.nix /etc/nixos/

sudo cp -r configfiles/ /etc/
sudo cp -r scripts/ /etc/

sudo nixos-rebuild switch
