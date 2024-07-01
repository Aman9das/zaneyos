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
    jq
    fastfetch
    hypridle
    gnome.file-roller
    swaynotificationcenter
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
    transmission_4-gtk
    libreoffice-fresh
    loupe
    _64gram
    protonup-qt
    gimp
    # monophony
    ferdium
    gnome.gnome-disk-utility
    libsForQt5.dolphin
    yt-dlp

    vscode-fhs

    # Import Scripts
    # (import ./../scripts/emopicker9000.nix {inherit pkgs;})
    (import ./../scripts/task-waybar.nix {inherit pkgs;})
    # (import ./../scripts/squirtle.nix {inherit pkgs;})
    # (import ./../scripts/wallsetter.nix {
    #   inherit pkgs;
    #   inherit wallpaperDir;
    #   inherit username;
    #   inherit wallpaperGit;
    # })
    # (import ./../scripts/themechange.nix {
    #   inherit pkgs;
    #   inherit flakeDir;
    #   inherit host;
    # })
    # (import ./../scripts/theme-selector.nix {inherit pkgs;})
    (import ./../scripts/nvidia-offload.nix {inherit pkgs;})
    (import ./../scripts/web-search.nix {inherit pkgs;})
    (import ./../scripts/exit-apps.nix {inherit pkgs;})
    (import ./../scripts/rofi-exit.nix {inherit pkgs;})
    (import ./../scripts/rofi-shot.nix {inherit pkgs;})
    (import ./../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../scripts/scroller-fit.nix {inherit pkgs;})
    # (import ./../scripts/screenshootin.nix {inherit pkgs;})
    # (import ./../scripts/list-hypr-bindings.nix {
    #   inherit pkgs;
    #   inherit host;
    # })
  ];

  programs.gh.enable = true;
}
