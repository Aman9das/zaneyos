{
  pkgs,
  config,
  lib,
  host,
  ...
}: let
  # palette = config.colorScheme.palette;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../../hosts/${host}/options.nix) bar-number clock24h hwmon-cpu;
in
  with lib; {
    # Configure & Theme Waybar
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";

          modules-center = ["hyprland/workspaces"];
          modules-left = ["clock" "hyprland/window" "group/groupcpu"];
          modules-right = ["pulseaudio" "custom/exit" "idle_inhibitor" "custom/notification" "tray" "battery"];

          "hyprland/workspaces" = {
            format-icons = {
              default = " ";
              empty = " ";
            };
            format = "{icon}{windows}{icon}";
            format-window-separator = " ";
            window-rewrite-default = "󰙵";
            window-rewrite = import ./waybar-app-icons.nix;
          };
          "clock" = {
            format =
              if clock24h == true
              then ''{:L%H:%M}''
              else ''{:L%I:%M %p}'';
            tooltip = true;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              on-scroll = 1;
              format = {
                months = "<span color='#fafafa'><b>{}</b></span>";
                days = "<span color='#fafafa'><b>{}</b></span>";
                weeks = "<span color='#8ff0a4'><b>W{}</b></span>";
                weekdays = "<span color='#78aeed'><b>{}</b></span>";
                today = "<span color='#f66151'><b><u>{}</u></b></span>";
              };
            };
          };
          "hyprland/window" = {
            max-length = 48;
            # icons = true;
            icon-size = 16;
            separate-outputs = false;
            rewrite = {
              "" = " Desktop ";
            };
            format = "{title}";
            tooltip = true;
            tooltip-format = "{title}";
            on-click = "rofi-launcher";
          };
          "group/groupcpu" = {
            orientation = "inherit";
            modules = [
              "cpu" # First element is the "group leader" and won't ever be hidden
              "memory"
              "disk"
              # "network"
              "temperature"
            ];
            drawer = {
              transition-duration = 250;
              transition-left-to-right = true;
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage}%";
            tooltip = true;
            on-click = "hyprctl dispatch exec [workspace current] xdg-terminal-exec btop";
          };
          "disk" = {
            format = " {percentage_used}%";
            tooltip = true;
          };
          "temperature" = {
            hwmon-path = hwmon-cpu;
            format = " {temperatureC}°C";
            tooltip = false;
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
            format-bluetooth-muted = "  {icon} {format_source}";
            format-muted = "  {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "hyprctl dispatch exec [workspace current] pavucontrol";
          };
          "custom/themeselector" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && theme-selector";
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "rofi-exit";
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
              activated = "󰅶";
              deactivated = "󰾪";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
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
            tooltip = true;
            tooltip-format = "󱐋 {power}W";
          };
        }
      ];
      style = concatStrings [
        ''
          * {
          font-size: 14px;
          }

          #window, #memory, #clock, #cpu, #disk, #battery, #network, #custom-hyprbindings,
          #tray, #custom-notification, #pulseaudio, #custom-startmenu,
          #custom-exit, #custom-themeselector, #idle_inhibitor, #temperature,
          #group-groupcpu {
              margin: 0 2px 1px 2px;
              background-color: #1e1e1e; /* Base */
              border-radius: 10px;
              padding: 2px 10px;
              font-family: Rec Mono Linear, Simple Icons, Symbols Nerd Font, JetBrains Mono, sans-serif;
          }

          #clock, #window {
            font-weight: bold;
          }

          #workspaces button {
              border: none;
              border-radius: 10px;
              color: #fafafa; /* Text */
              font-weight: 400;
              transition: all 150ms ease;
              padding-top: 0;
              padding-bottom: 0;
          }

          #workspaces button:not(:last-child) {
              margin-right: 2px;
              transition: all 150ms ease;
          }

          #workspaces button:hover {
              background-color: #78aeed; /* Surface0 */
              transition: all 150ms ease;
          }

          #workspaces button.active {
              background-color: #3584e4; /* Muave */
              color: #fafafa; /* Base */
              padding-left: 16px;
              padding-right: 16px;
              transition: all 150ms ease;
          }

          window#waybar {
              background: transparent;
              background-color: transparent;
              color: #fafafa; /* Text */
          }

          window#waybar.empty, window#waybar.floating {
              background: transparent;
              background-color: transparent;
          }

          #idle_inhibitor {
              font-size: 16px;
          }

          #workspaces {
              background-color: #1e1e1e; /* Base */
              border-radius: 10px;
              margin: 0 2px 1px 2px;
              padding: 0px 0px;
              transition: all 150ms ease;
              font-family: Rec Mono Linear, Simple Icons, Symbols Nerd Font, JetBrains Mono, sans-serif;
          }

          #custom-startmenu {
              padding: 0px 0px;
          }

          #battery.warning {
            background-color: #cd9309;
          }
          #battery.critical {
            background-color: #c01c28;
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
