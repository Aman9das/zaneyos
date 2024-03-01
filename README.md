<div align="center">

## ZaneyOS 🟰 Best ❄️ NixOS Configs

ZaneyOS is a simple way of reproducing my configuration on any NixOS system. This includes the wallpaper, scripts, applications, config files, and more.

<img align="center" width="80%" src="https://gitlab.com/Zaney/zaneyos/-/raw/main/config/home/files/media/demo.jpg" />

</div>

> **This project has a [Wiki](https://zaney.org/zaneyos/). Please read it to find out information on subjects that you may need to learn more about!**
> **I have put a lot of effort into the [documentation](https://zaney.org/zaneyos/) so it should be accurate. However, please if you notice that something is wrong with it create an issue or reach out to me on Discord.**

#### 🍖 Requirements
- You must be running on NixOS.
- Must have installed using GPT & UEFI.
- Change settings through script or manually editing options.nix file.

#### 🎹 Pipewire, Spotify, & Notification Menu Controls
- We are using the latest and greatest audio solution for Linux. If you like listening to music Spotify comes pre-installed out of the box. Not to mention you will have media and volume controls in the notification center available in the top bar.

#### 🏇 Optimized Workflow, tmpfs For Speed, & Simple Yet Elegant Neovim
- Using scratchpads with Hyprland for increased functionality and effeciency.
- A tmpfs for the /tmp directory is created improving rebuild time and reducing strain on hdd/ssd.
- No massive Neovim project here. This is my simple, easy to understand, yet incredible Neovim setup. You can grep recursively through entire folders and find specific files without ever leaving the text editor!

<div align="center">

![](./config/home/files/media/demo.mp4)

Please do yourself a favor and [read the wiki](https://zaney.org/zaneyos/).

</div>

#### 📦 How To Install Packages?
- You can search the [Nix Packages](https://search.nixos.org/packages?) & [Options](https://search.nixos.org/options?) pages for what a package may be named or if it has options available that take care of configuration hurdles you may face.
- To add a package there are the packages.nix files located in config/system and config/home folders. One is for programs available system wide and the other for your users environment only.

#### 🙋 Having Issues / Questions?
- Please feel free to raise an issue on the repo, please label a feature request with the title beginning with [feature request], thank you!
- Contact me on [Discord](https://discord.gg/2cRdBs8) as well, for a potentially faster response.

#### ⚠️ Important Changes!
- **The stable branch is gone, this means this project changes as my system changes. This will help with managing documentation. From now on before updating the repository please ensure the flake is not in maintenance mode. If an announcement has not been made on top of this page and Discord then its safe to pull and use the repository.**
- The [Wiki](https://zaney.org/zaneyos/) has moved to [my website](https://zaney.org). This will make it so the documentation looks better and is more easily searched. You can click the search icon in the menu, on desktop, to search through any page in the entire website.
- **Impermanence/persistence has been moved to only being sourced inside the hardware.nix file. If you want to use this feature then please read the Wiki page about how to implement it.**

### ⬇️ Install

#### 📜 Script:

This is the easiest and recommended way of starting out. The script is not meant to allow you to change every option that you can in the flake or help you install extra packages. It is simply here so you can get my configuration installed with as little chances of breakages and then fiddle to your hearts content!

Simply copy this and run it:

```
nix-shell -p git curl
sh <(curl -L https://gitlab.com/Zaney/zaneyos/-/raw/main/install-zaneyos.sh)
```

#### 🦽 Manual:

Run this command to ensure Git & Vim are installed:

```
nix-shell -p git vim
```

Clone this repo & enter it:

```
git clone https://gitlab.com/zaney/zaneyos.git
cd zaneyos
```

- *You should stay in this folder for the rest of the install*

**🪧🪧🪧 Edit options.nix 🪧🪧🪧**

Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hardware.nix
```

Run this to enable flakes and install the flake replacing hostname with whatever you put in the options.nix file:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#hostname
```

This Flake's user will have the password be set for them as *password*. If you want to change it run a command replacing password with whatever you want to be your password. You then need to copy the output that it gives you like below into your hashedPassword in the system.nix file.

```
  mkpasswd -m sha-512 password

$6$YdPBODxytqUWXCYL$AHW1U9C6Qqkf6PZJI54jxFcPVm2sm/XWq3Z1qa94PFYz0FF.za9gl5WZL/z/g4nFLQ94SSEzMg5GMzMjJ6Vd7.
```

Now when you want to rebuild the configuration you have access to an alias called flake-rebuild that will rebuild the flake based of the flakeDir variable you set in options.nix!

Hope you enjoy!
