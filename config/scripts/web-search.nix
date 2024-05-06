{ pkgs }:

pkgs.writeShellScriptBin "web-search" ''
  if pgrep -x "rofi" > /dev/null; then
    # Rofi is running, kill it
    pkill -x rofi
    exit 0
  fi

  declare -A URLS

  URLS=(
    ["  Search"]="https://duckduckgo.com/?q="
    ["  Unstable Packages"]="https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query="
    ["  YouTube"]="https://www.youtube.com/results?search_query="
    ["󰣇 Arch Wiki"]="https://wiki.archlinux.org/title/"
    ["󰣨 Gentoo Wiki"]="https://wiki.gentoo.org/index.php?title="
  )

  # List for rofi
  gen_list() {
    for i in "''${!URLS[@]}"
    do
      echo "$i"
    done
  }

  main() {
    # Pass the list to rofi
    platform=$( (gen_list) | ${pkgs.rofi-wayland}/bin/rofi -dmenu )

    if [[ -n "$platform" ]]; then
      query=$( ${pkgs.rofi-wayland}/bin/rofi -dmenu )

      if [[ -n "$query" ]]; then
	url=''${URLS[$platform]}$query
	xdg-open "$url"
      else
	exit
      fi
    else
      exit
    fi
  }

  main

  exit 0
''
