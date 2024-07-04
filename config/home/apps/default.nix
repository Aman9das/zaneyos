{ pkgs, config, ... }:
{
  imports = [
    ./thunderbird.nix
    ./zeroad.nix
    ./blender.nix
    ./rofi.nix
    ./bw.nix
    ./mpv.nix
    ./logseq.nix
    ./vivaldi.nix
    ./firefox.nix
    ./syncthing.nix
    ./nemo.nix
    ./qutebrowser.nix
    ./kdeconnect.nix
    ./video-editor.nix
  ];
}
