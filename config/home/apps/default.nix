{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./mail.nix
    ./zeroad.nix
    ./blender.nix
    ./vivaldi.nix
    ./firefox.nix
    ./nemo.nix
    ./qutebrowser.nix
  ];
}
