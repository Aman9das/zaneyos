{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./thunderbird.nix
    ./zeroad.nix
    ./blender.nix
    ./rofi.nix
    ./neovim.nix
    ./bw.nix
    ./vivaldi.nix
    ./firefox.nix
    ./nemo.nix
    ./qutebrowser.nix
  ];
}
