{
  pkgs,
  config,
  inputs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    cmatrix
    lolcat
    neofetch
    htop
    btop
    libvirt
    polkit_gnome
    lm_sensors
    unzip
    unrar
    libnotify
    eza
    v4l-utils
    ydotool
    wl-clipboard
    socat
    cowsay
    lsd
    lshw
    pkg-config
    meson
    libgccjit
    hugo
    gnumake
    ninja
    go
    nodejs
    symbola
    brightnessctl
    virt-viewer
    swappy
    ripgrep
    appimage-run
    networkmanagerapplet
    # yad
    playerctl
    nh
    xdg-terminal-exec
    rsync
    pulseaudio
    ydotool
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-color-emoji
    material-icons
    font-awesome
    (nerdfonts.override {fonts = ["JetBrainsMono" "NerdFontsSymbolsOnly"];})
  ];

  programs = {
    steam.gamescopeSession.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    ydotool.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  hardware.opentabletdriver.enable = true;

  services.xserver = {
    excludePackages = with pkgs; [xterm];
    desktopManager = {
      cinnamon.enable = true;
    };
  };

  services.cinnamon.apps.enable = false;
}
