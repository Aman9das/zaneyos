# PLEASE READ THE WIKI FOR DETERMINING
# VALUES FOR THIS PAGE. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

{
  # User Variables
  gitUsername = "Tyler Kelley";
  gitEmail = "tylerzanekelley@gmail.com";
  theme = "gigavolt";
  waybarStyle = "style2"; # can be style1-2
  borderAnim = true; # anything other than on disables anim borders in Hyprland
  browser = "firefox";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
  wallpaperDir = "/home/zaney/Pictures/Wallpapers";
  flakeDir = "/home/zaney/zaneyos";

  # System Settings
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "pl";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/Chicago";
  cpuType = "intel";
  gpuType = "amd";

  # Optional Settings
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";
  localHWClock = false;
  ntp = true;
  flatpak = false;
  kdenlive = true;
  blender = true;

}
