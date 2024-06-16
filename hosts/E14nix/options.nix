# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS.
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options
let
  setUsername = "aman";
  setHostname = "E14nix";
in {
  # No Change Needed Below
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/zaneyos";
  wallpaperGit = "https://github.com/Aman9das/my-walls.git"; # Can be changed IF you know what your doing
  wallpaperDir = "/home/${setUsername}/pictures/Wallpapers";
  screenshotDir = "/home/${setUsername}/pictures/Screenshots";
  flakePrev = "/home/${setUsername}/.zaneyos-previous";
  flakeBackup = "/home/${setUsername}/.zaneyos-backup";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Aman9das";
  gitEmail = "amandas62640@gmail.com";

  # Base16 Theme
  theme = "tomorrow-night";

  # Hyprland Settings
  borderAnim = false; # Enable / Disable Hyprland Border Animation
  extraMonitorSettings = "";

  # Waybar Settings
  waybarAnim = false; # Enable / Disable Waybar Animation CSS
  bar-number = true; # Enable / Disable Workspace Numbers In Waybar

  # System Settings
  clock24h = false;
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "";
  theKBDVariant = "";
  theLCVariables = "en_IN";
  theTimezone = "Asia/Kolkata";
  theShell = "nushell"; # Possible options: bash, zsh, nushell
  theKernel = "default"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "x11"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "amd";
  gpuType = "amd";

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS!
  intel-bus-id = "PCI:1:0:0";
  nvidia-bus-id = "PCI:0:2:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = true;

  # Program Options
  browser = "vivaldi"; # Install & Set Default Browser
  terminal = "kitty"; # Set Default System Terminal
  distrobox = true;
  flatpak = true;
  kdenlive = false;
  blender = false;
  enableZeroAD = false;

  # Enable Support For
  # Logitech Devices
  logitech = false;

  # Enable Terminals ( If You Disable All You Get Kitty )
  wezterm = false;
  alacritty = false;
  kitty = true;

  # Enable Python & PyCharm
  python = true;

  # Enable SyncThing
  syncthing = true;

  hwmon-cpu = "/sys/class/hwmon/hwmon5/temp1_input";
}
