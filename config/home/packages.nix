{
  pkgs,
  config,
  username,
  host,
  ...
}: let
  inherit
    (import ../../hosts/${host}/options.nix)
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    ;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    libvirt
    hypridle
    gnome.file-roller
    swaynotificationcenter
    rofi-wayland
    imv
    obs-studio
    pavucontrol
    tree
    cliphist
    nix-prefetch-github
    grimblast
    localsend

    easyeffects

    xournalpp
    calibre
    celluloid
    transmission-gtk
    libreoffice-fresh
    loupe
    telegram-desktop
    protonup-qt
    gimp
    monophony
    ferdium
    gnome.gnome-disk-utility
    (makeAutostartItem {
      name = "ferdium";
      package = ferdium;
    })
    libsForQt5.dolphin

    vscode-fhs

    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    inter
    font-awesome

    # Import Scripts
    (import ./../scripts/emopicker9000.nix {inherit pkgs;})
    (import ./../scripts/task-waybar.nix {inherit pkgs;})
    # (import ./../scripts/squirtle.nix {inherit pkgs;})
    (import ./../scripts/wallsetter.nix {
      inherit pkgs;
      inherit wallpaperDir;
      inherit username;
      inherit wallpaperGit;
    })
    (import ./../scripts/themechange.nix {
      inherit pkgs;
      inherit flakeDir;
      inherit host;
    })
    # (import ./../scripts/theme-selector.nix {inherit pkgs;})
    (import ./../scripts/nvidia-offload.nix {inherit pkgs;})
    (import ./../scripts/web-search.nix {inherit pkgs;})
    (import ./../scripts/rofi-exit.nix {inherit pkgs;})
    (import ./../scripts/rofi-shot.nix {inherit pkgs;})
    (import ./../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../scripts/scroller-center.nix {inherit pkgs;})
    # (import ./../scripts/screenshootin.nix {inherit pkgs;})
    # (import ./../scripts/list-hypr-bindings.nix {
    #   inherit pkgs;
    #   inherit host;
    # })
  ];

  programs.gh.enable = true;
}
