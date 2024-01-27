{ pkgs, config, inputs, ... }:

let
  my-python-packages = ps: with ps; [
    pandas
    requests
  ];
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget curl git cmatrix lolcat neofetch htop btop libvirt
    polkit_gnome lm_sensors unzip unrar libnotify eza
    v4l-utils ydotool wl-clipboard socat cowsay lsd lshw
    pkg-config meson hugo gnumake ninja go nodejs symbola
    noto-fonts-color-emoji material-icons brightnessctl
    toybox virt-viewer jetbrains.pycharm-community-bin
    (pkgs.python3.withPackages my-python-packages)
  ];

  programs.steam.gamescopeSession.enable = true;
  programs.dconf.enable = true;
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
