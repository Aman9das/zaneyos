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
      material-icons
      font-awesome
      noto-fonts-cjk-sans
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "RecMonoDuotone Nerd Font"
        "RecMonoLinear Nerd Font"
        "Noto Color Emoji"
        "Noto Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "DejaVu Sans Mono"
        "Noto Sans Mono CJK JP"
        "Noto Sans Mono CJK KR"
        "Noto Sans Mono CJK HK"
        "Noto Sans Mono CJK SC"
        "Noto Sans Mono CJK TC"
      ];
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      sansSerif = [
        "Recursive Sans Linear"
        "Recursive Sans Linear Static"
        "Noto Color Emoji"
        "Noto Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans CJK HK"
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
      ];
      serif = [
        "Recursive Sans Casual"
        "Recursive Sans Casual Static"
        "Noto Color Emoji"
        "Noto Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
        "Noto Sans CJK JP"
        "Noto Sans CJK KR"
        "Noto Sans CJK HK"
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
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
