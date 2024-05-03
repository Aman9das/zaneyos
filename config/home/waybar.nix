{ pkgs, config, lib, host, ... }:

let
  palette = config.colorScheme.palette;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../hosts/${host}/options.nix) bar-number clock24h waybarAnim;
in with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";

      modules-center = [ "hyprland/workspaces" ] ;
      modules-left = [ "clock" "hyprland/window" "cpu" ];
      modules-right = [ "pulseaudio" "custom/exit" "idle_inhibitor" "custom/notification" "tray" "battery" ];

      "hyprland/workspaces" = {
      	format = if bar-number == true then "{name}" else "{icon}";
      	format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
      	};
      	on-scroll-up = "hyprctl dispatch workspace e+1";
      	on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
	format = if clock24h == true then ''{:L%H:%M}''
	else ''{:L%I:%M %p}'';
      	tooltip = true;
	tooltip-format = "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
  on-click = "rofi-launcher";
      };
      "hyprland/window" = {
      	max-length = 32;
        separate-outputs = false;
        rewrite = { "" = " Desktop "; };
      };
      "memory" = {
      	interval = 5;
      	format = " {}%";
        tooltip = true;
      };
      "cpu" = {
      	interval = 5;
      	format = "{usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = "{free}";
        tooltip = true;
      };
      "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = {
        spacing = 12;
      };
      "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "sleep 0.1 && pavucontrol";
      };
      "custom/themeselector" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && theme-selector";
      };
      "custom/exit" = {
        tooltip = false;
        format = "";
        on-click = "wlogout";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = "";
        # exec = "rofi -show drun";
        on-click = "sleep 0.1 && rofi-launcher";
      };
      "custom/hyprbindings" = {
        tooltip = false;
        format = "?";
        on-click = "sleep 0.1 && list-hypr-bindings";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
            activated = "";
            deactivated = "";
        };
        tooltip = "true";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
       	};
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        on-click = "";
        tooltip = false;
      };
    }];
    style = concatStrings [''
* {
font-size: 14px;
font-family: JetBrainsMono Nerd Font Propo, Font Awesome, sans-serif;
font-weight: bold;
}

button {
    border: none;
    border-radius: 10px;
    transition: background-color 250ms ease;
    color: #fafafa; /* Text */
    font-weight: 400;
}

button:hover {
    background-color: #78aeed; /* Surface0 */
}

button.active {
    background-color: #3584e4; /* Muave */
    color: #fafafa; /* Base */
}

window#waybar {
    background-color: #000000;
    color: #fafafa; /* Text */
}

window#waybar.empty {
background: transparent;
background-color: transparent;
}

#window, #memory, #clock, #cpu, #disk, #battery, #network, #custom-hyprbindings,
#tray, #custom-notification, #pulseaudio, #workspaces, #custom-startmenu,
#custom-exit, #custom-themeselector, #idle_inhibitor {
    margin: 4px;
    margin-bottom: 4px;
    background-color: #1e1e1e; /* Base */
    border-radius: 10px;
    padding: 2px 10px;
}

#workspaces {
    margin: 0px;
    padding: 0px 0px;
    margin-bottom: 2px;
    border: 1px solid #383838;
}

#custom-startmenu {
    padding: 0px 0px;
}

tooltip {
background: #242424;
border-radius: 10px;
}
tooltip label {
color: #ffffff;
}

#custom-startmenu {
    background-size: 300% 300%;
}
''
    ];
  };
}
