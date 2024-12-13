{
  pkgs,
  pkgs-unstable,
  config,
  inputs,
  ...
}:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    cmatrix
    btop
    socat
    libvirt
    polkit_gnome
    lm_sensors
    unzip
    unrar
    fzf
    ripgrep
    libnotify
    v4l-utils
    wl-clipboard
    lshw
    pkg-config
    meson
    libgccjit
    hugo
    gnumake
    jdk
    ninja
    go
    icu
    nodejs
    symbola
    brightnessctl
    virt-viewer
    ripgrep
    appimage-run
    networkmanagerapplet
    wtype
    playerctl
    nh
    xdg-terminal-exec
    rsync
    pulseaudio
    glibc
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
      noto-fonts-color-emoji
      material-icons
      font-awesome
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "RecMonoDuotone Nerd Font"
        "RecMonoLinear Nerd Font"
        "Noto Color Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
      ];
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
      sansSerif = [
        "Recursive Sans Linear"
        "Recursive Sans Linear Static"
        "Noto Color Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
      ];
      serif = [
        "Recursive Sans Casual"
        "Recursive Sans Casual Static"
        "Noto Color Emoji"
        "Symbols Nerd Font Mono"
        "Simple Icons"
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

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  virtualisation.waydroid.enable = true;

  hardware.opentabletdriver = {
    enable = true;
    package = pkgs-unstable.opentabletdriver;
  };

  services.xserver = {
    excludePackages = with pkgs; [ xterm ];
    desktopManager = {
      gnome.enable = true;
      # cinnamon.enable = true;
    };
    displayManager.session = [ ];
  };

  services.cinnamon.apps.enable = false;
  services.gnome = {
    core-utilities.enable = false;
    localsearch.enable = false;
    tinysparql.enable = false;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-28.3.3"
    "electron-27.3.11"
    "freeimage-unstable-2021-11-01"
  ];
}
