{ pkgs, config, username, host, ... }:

let
  inherit (import ../../hosts/${host}/options.nix)
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    libvirt swww grim slurp gnome.file-roller
    swaynotificationcenter rofi-wayland imv transmission-gtk mpv
    gimp obs-studio audacity pavucontrol tree protonup-qt
    font-awesome swayidle swaylock cliphist nix-prefetch-github

    xournalpp calibre
    libreoffice-fresh image-roll telegram-desktop


    qt5ct qt6ct libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5.qtwayland
    libsForQt5.dolphin

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    inter

    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; inherit host; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; inherit host; })
  ];

  programs.gh.enable = true;
}
