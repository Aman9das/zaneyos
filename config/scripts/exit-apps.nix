{pkgs, ...}:
pkgs.writeShellScriptBin "exit_apps" ''
  # Close Applications
  main() {
    HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
    hyprctl --batch "$HYPRCMDS" 2>&1
  }

  main
''
