{
  pkgs,
  pkgs-unstable,
  config,
  username,
  host,
  ...
}:
{
  # Install Packages For The User
  home.packages = with pkgs; [
    libvirt
    jq
    fastfetch
    hypridle
    file-roller
    swaynotificationcenter
    imv
    obs-studio
    pavucontrol
    tree
    cliphist
    nix-prefetch-github
    grimblast

    easyeffects
    localsend

    xournalpp
    celluloid
    transmission_4-gtk
    libreoffice-fresh
    loupe
    _64gram
    protonplus
    gimp
    # monophony
    ferdium
    gnome-disk-utility
    baobab
    evince
    kdePackages.okular
    # android-studio
    parabolic

    ente-auth
    bitwarden-desktop

    (retroarch.override {
      cores = with libretro; [
        genesis-plus-gx
        snes9x
        mame2003-plus
        fbneo
        fbalpha2012
        puae
        dosbox-pure
        gambatte
        mgba
        beetle-vb
        melonds
        fceumm
        mupen64plus
        dolphin
        scummvm
        opera
        picodrive
        beetle-saturn
        flycast
        swanstation
        pcsx2
        ppsspp
      ];
    })
    bottles
    heroic

    vscode-fhs

    google-chrome

    # Import Scripts
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    # (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/exit-apps.nix { inherit pkgs; })
    (import ./../scripts/rofi-exit.nix { inherit pkgs; })
    (import ./../scripts/rofi-shot.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/rofi-alttab.nix { inherit pkgs; })
    (import ./../scripts/scroller-fit.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
