{ config, pkgs, inputs, username,
  gitUsername, gitEmail, gtkThemeFromScheme,
  theme, browser, wallpaperDir, wallpaperGit,
  flakeDir, ... }:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  # Import Program Configurations
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./config/home/waybar.nix
    ./config/home/swaync.nix
    ./config/home/swaylock.nix
    ./config/home/neofetch.nix
    ./config/home/hyprland.nix
    ./config/home/kitty.nix
    ./config/home/rofi.nix
    ./config/home/vim.nix
    ./config/home/files.nix
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Starship Prompt
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = {
        add_newline = true;
        character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
        };
        package = {
            disabled = false;
        };
    };
  };

  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}" neofetch lolcat cmatrix discord htop btop libvirt
    swww polkit_gnome grim slurp lm_sensors unzip unrar gnome.file-roller
    libnotify swaynotificationcenter rofi-wayland imv v4l-utils
    ydotool wl-clipboard socat cowsay lsd pkg-config transmission-gtk mpv
    gimp obs-studio blender kdenlive meson hugo gnumake ninja go
    nodejs godot_4 rustup pavucontrol audacity zeroad xonotic
    openra font-awesome symbola noto-fonts-color-emoji material-icons
    spotify brightnessctl swayidle wget curl
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./config/scripts/emopicker9000.nix { inherit pkgs; })
    (import ./config/scripts/task-waybar.nix { inherit pkgs; })
    (import ./config/scripts/squirtle.nix { inherit pkgs; })
    (import ./config/scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir; })
    (import ./config/scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./config/scripts/theme-selector.nix { inherit pkgs; })
  ];


  # Configure Cursor Theme
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Theme GTK
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 12;
      package = pkgs.ubuntu_font_family;
    };
    theme = {
      name = "${config.colorScheme.slug}";
      package = gtkThemeFromScheme {scheme = config.colorScheme;};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
    };
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };

  # Configure Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    sessionVariables = {
    
    };
    shellAliases = {
      sv="sudo vim";
      flake-rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
      laptop-rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="vim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
    };
  };

  programs.home-manager.enable = true;
}
