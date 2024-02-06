{
  # User Variables
  gitUsername = "Tyler Kelley";
  gitEmail = "tylerzanekelley@gmail.com";
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/Chicago";
  theme = "rose-pine";
  waybarStyle = "style2"; # can be style1-2
  borderAnim = "on"; # anything other than on disables anim borders in Hyprland
  browser = "firefox";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
  wallpaperDir = "/home/zaney/Pictures/Wallpapers";
  flakeDir = "/home/zaney/zaneyos";
  # Driver selection profile
  # Options include amd (tested), intel, nvidia
  # GPU hybrid options: intel-nvidia, intel-amd
  # vm for both if you are running a vm
  cpuType = "intel";
  gpuType = "amd";
  # Run: sudo lshw -c display to find this info
  # This is needed ONLY for hybrid nvidia offloading
  # Run: nvidia-offload (insert program name)
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";
}
