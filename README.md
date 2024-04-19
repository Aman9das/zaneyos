<div align="center">

## ZaneyOS 🟰 Best ❄️ NixOS Configs

**ZaneyOS Development Branch**

ZaneyOS is a simple way of reproducing my configuration on any NixOS system. This includes the wallpaper, scripts, applications, config files, and more.

<img align="center" width="80%" src="https://gitlab.com/Zaney/zaneyos/-/raw/main/config/home/files/media/demo.jpg" />

</div>

> **This project has a [Wiki](https://zaney.org/zaneyos/). Please read it to find out information on subjects that you may need to learn more about!**
> **I have put a lot of effort into the [documentation](https://zaney.org/zaneyos/) so it should be accurate. However, please if you notice that something is wrong with it create an issue or reach out to me on Discord.**

#### 🍖 Requirements
- You must be running on NixOS.
- Must have installed using GPT & UEFI.
- Manually editing options.nix file in hosts/<yourhostname> folder.

#### 🎹 Pipewire, Spotify, & Notification Menu Controls
- We are using the latest and greatest audio solution for Linux. If you like listening to music Spotify comes pre-installed out of the box. Not to mention you will have media and volume controls in the notification center available in the top bar.

#### 🏇 Optimized Workflow, tmpfs For Speed, & Simple Yet Elegant Neovim
- Using scratchpads with Hyprland for increased functionality and effeciency.
- A tmpfs for the /tmp directory is created improving rebuild time and reducing strain on hdd/ssd.
- No massive Neovim project here. This is my simple, easy to understand, yet incredible Neovim setup. You can grep recursively through entire folders and find specific files without ever leaving the text editor!

#### 🖥️ Multi Host & User Configuration
- You can now define separate settings for different host machines and users!
- Easily specify extra packages for your users in the users/users.nix file.
- Easy to understand file structure where each host just has its generated hardware.nix file and option.nix file in a folder with the hostname as its title.

#### 👼 An Incredible Community Focused On Support
- The entire idea of ZaneyOS is to make NixOS an approachable space that is actually a great community that you want to be in.
- Many people who are patient and happy to spend their free time helping you are running ZaneyOS. Feel free to reach out on the Discord for any help with anything.

<div align="center">

![](./config/home/files/media/demo.mp4)

Please do yourself a favor and [read the wiki](https://zaney.org/zaneyos/).

</div>

#### 📦 How To Install Packages?
- You can search the [Nix Packages](https://search.nixos.org/packages?) & [Options](https://search.nixos.org/options?) pages for what a package may be named or if it has options available that take care of configuration hurdles you may face.
- To add a package there are the packages.nix files located in config/system and config/home folders. One is for programs available system wide and the other for your users environment only.
- You also have the option of easily adding packages to the option in the users/users.nix file for a specific user.

#### 🙋 Having Issues / Questions?
- Please feel free to raise an issue on the repo, please label a feature request with the title beginning with [feature request], thank you!
- Contact me on [Discord](https://discord.gg/2cRdBs8) as well, for a potentially faster response.

#### ⚠️ Important Changes!
- **ZaneyOS versioning is making its return!** You will now be able to see there are branches labeled as stable. The main branch is the development branch now.
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

Create the host folder for your machine(s)

```
cp -r hosts/default hosts/<your-desired-hostname>
```

**🪧🪧🪧 Edit options.nix 🪧🪧🪧**

Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hosts/<your-desired-hostname>/hardware.nix
```

Run this to enable flakes and install the flake replacing hostname with whatever you put in the hosts/<your-desired-hostname>/options.nix file:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#hostname
```

If the username is new, the new user will have the password be set for them as *password*. If you want to change it run a command replacing password with whatever you want to be your password. You then need to copy the output that it gives you like below into your hashedPassword in the system.nix file.

```
  mkpasswd -m sha-512 password

$6$YdPBODxytqUWXCYL$AHW1U9C6Qqkf6PZJI54jxFcPVm2sm/XWq3Z1qa94PFYz0FF.za9gl5WZL/z/g4nFLQ94SSEzMg5GMzMjJ6Vd7.
```

Now when you want to rebuild the configuration you have access to an alias called flake-rebuild that will rebuild the flake based of the flakeDir variable you set in options.nix!

Hope you enjoy!
