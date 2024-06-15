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
    wtype
    playerctl
    nh
    xdg-terminal-exec
    rsync
    pulseaudio
  ];

  fonts = {
    enableDefaultPackages = false;
    enableGhostscriptFonts = false;
    packages = with pkgs; [
      jetbrains-mono
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
          "Recursive"
        ];
      })
      recursive
      inter
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "RecMonoDuotone Nerd Font"
        "RecMonoLinear Nerd Font"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "Noto Color Emoji"
        "Noto Emoji"
        "DejaVu Sans Mono"
      ];
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      sansSerif = [
        "Recursive Sans Linear"
        "Recursive Sans Linear Static"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "Noto Color Emoji"
        "Noto Emoji"
        "DejaVu Sans Mono"
      ];
      serif = [
        "Recursive Sans Casual"
        "Recursive Sans Casual Static"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "Noto Color Emoji"
        "Noto Emoji"
        "DejaVu Sans Mono"
      ];
    };
  };

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
