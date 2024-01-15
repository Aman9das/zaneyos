{ config, pkgs, inputs, username,
  gitUsername, gitEmail, gtkThemeFromScheme, ... }:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./config/waybar.nix
    ./config/neofetch.nix
    ./config/hyprland.nix
    ./config/kitty.nix
    ./config/rofi.nix
    ./config/vim.nix
    ./config/files.nix
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

  # Install Packages For The User
  home.packages = with pkgs; [
    neofetch lolcat cmatrix discord firefox btop libvirt
    swww polkit_gnome grim slurp lm_sensors unzip unrar gnome.file-roller
    libnotify swaynotificationcenter rofi-wayland imv v4l-utils
    ydotool wl-clipboard socat cowsay lsd pkg-config transmission-gtk mpv
    gimp obs-studio blender kdenlive meson hugo gnumake ninja go
    nodejs godot_4 rustup pavucontrol audacity zeroad xonotic
    openra font-awesome symbola noto-fonts-color-emoji material-icons
    spotify
    # Import Scripts
    (import ./scripts/emopicker9000.nix { inherit pkgs; })
    (import ./scripts/task-waybar.nix { inherit pkgs; })
    (import ./scripts/squirtle.nix { inherit pkgs; })
    (import ./scripts/wallsetter.nix { inherit pkgs; })
  ];

  # Configure Cursor Theme
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Enable & Configure QT
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

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
      flake-rebuild="sudo nixos-rebuild switch --flake ~/zaneyos/#workstation";
      laptop-rebuild="sudo nixos-rebuild switch --flake ~/zaneyos/#laptop";
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
