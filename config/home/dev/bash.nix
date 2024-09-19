{
  config,
  lib,
  pkgs,
  host,
  ...
}:
let
  inherit (import ../../../hosts/${host}/options.nix)
    flakeDir
    flakePrev
    hostname
    flakeBackup
    theShell
    ;
in
{
  # Configure Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initExtra = "";
    sessionVariables = {
      ZANEYOS = true;
      FLAKEBACKUP = "${flakeBackup}";
      FLAKEPREV = "${flakePrev}";
    };
    shellAliases = {
      v = "nvim";
      ".." = "cd ..";
      neofetch = "fastfetch";
    };
  };
}
