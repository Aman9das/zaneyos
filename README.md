<div align="center">

# ZaneyOS 🟰 Best ❄️ NixOS Configs

ZaneyOS is a way of reproducing my configuration on any NixOS system. This includes the wallpaper, scripts, applications, config files, and more. *Please remember to change username and hostname in flake.nix.*

![](./config/home/files/media/demo.jpg)

</div>

## READ THE WIKI

If you want to learn more about my system, [this project has a Wiki](https://gitlab.com/Zaney/zaneyos/-/wikis/home) that explains a ton. It even explains what NixOS is why you may want to choose it and so much more.

<div align="center">

![](./config/home/files/media/demo.mp4)

Please do yourself a favor and [read the wiki](https://gitlab.com/Zaney/zaneyos/-/wikis/home).

</div>

# Install / Steps To Reproduce My System

- Run this command to ensure Git is installed:

```
nix-shell -p git vim 
```

- Clone this repo & enter it:

```
git clone https://gitlab.com/zaney/zaneyos.git
cd zaneyos
```

- *You should stay in this folder for the rest of the install*

**If you want to run a stable release you will need to run a command like this:**

```
git switch stable-1.0
```

### Change any options in options.nix that you may want / need to

- Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hardware.nix
```

- Run this to enable flakes and install the flake:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#thehostnameyousetinoptions.nix
```

## You Are Done!

This Flake's user will have the password be set for them as *password*. If you want to change it run a command replacing password with whatever you want to be your password. You then need to copy the output that it gives you like below into your hashedPassword in the system.nix file.

```
  mkpasswd -m sha-512 password

$6$YdPBODxytqUWXCYL$AHW1U9C6Qqkf6PZJI54jxFcPVm2sm/XWq3Z1qa94PFYz0FF.za9gl5WZL/z/g4nFLQ94SSEzMg5GMzMjJ6Vd7.
```

Now when you want to rebuild the configuration you have access to an alias called flake-rebuild that will rebuild the flake based of the flakeDir variable you set in options.nix!

Hope you enjoy!
