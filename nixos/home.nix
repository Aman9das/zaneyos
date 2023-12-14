{ config, pkgs, ... }:

{
  home.username = "zaney";
  home.homeDirectory = "/home/zaney";
  home.stateVersion = "23.11";

  home.file.".config/swaync/config.json" = {
    source = ../configfiles/swaync/config.json;
    recursive = true;
  };
  home.file.".Xresources" = {
    source = ../configfiles/.Xresources;
    recursive = true;
  };
  home.file.".config/wallpaper.png" = {
    source = ../configfiles/wallpaper.png;
    recursive = true;
  };
  home.file.".config/swaync/style.css" = {
    source = ../configfiles/swaync/style.css;
    recursive = true;
  };
  home.file.".config/pipewire/pipewire.conf" = {
    source = ../configfiles/pipewire/pipewire.conf;
    recursive = true;
  };
  home.file.".config/neofetch/config.conf" = {
    source = ../configfiles/neofetch/config.conf;
    recursive = true;
  };
  home.file.".local/share/scriptdeps/emoji" = {
    source = ../configfiles/emoji;
    recursive = true;
  };
  home.file.".local/share/fonts/UniSans-Heavy.otf" = {
    source = ../fonts/UniSans-Heavy.otf;
    recursive = true;
  };
  home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
  };
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
  gtk = {
      enable = true;
      font = {
	name = "Ubuntu Nerd Font";
	size = 12;
	package = pkgs.ubuntu_font_family;
    };
    theme = {
        name = "Tokyonight-Storm-BL";
        package = pkgs.tokyo-night-gtk;
    };
    iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
        Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
    gtk4.extraConfig = {
        Settings = ''
        gtk-application-prefer-dark-theme=1
        '';
    };
  };
  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
        $mainMod = SUPER
        bind = , XF86AudioRaiseVolume,	exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bind = , XF86AudioLowerVolume,	exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bind = , XF86AudioMute,			exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
        bind = , XF86AudioMicMute,		exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
        bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
        bind = , XF86MonBrightnessUp,   exec, brightnessctl set +5%
        bind = $mainMod,		Return, exec, kitty
        bind = $mainMod SHIFT,	Return, exec, tofi-drun | xargs hyprctl dispatch exec --
        bind = $mainMod SHIFT,	W,		exec, web-search
        bind = $mainMod,		W,		exec, firefox
        bind = $mainMod,		E,		exec, emopicker9000
        bind = $mainMod,		S,		exec, grim -g "$(slurp)"
        bind = $mainMod,		D,		exec, discord
        bind = $mainMod,		O,		exec, obs
        bind = $mainMod,		G,		exec, gimp
        bind = $mainMod,		T,		exec, thunar
        bind = $mainMod,		M,		exec, ario
        bind = $mainMod,		Q,		killactive,
        bind = $mainMod,		P,		pseudo, # dwindle
        bind = $mainMod SHIFT,	I,		togglesplit, # dwindle
        bind = $mainMod,	    F,		fullscreen,
        bind = $mainMod SHIFT,	F,		togglefloating,
        bind = $mainMod SHIFT,	C,		exit,
        bind = $mainMod SHIFT,	left,	movewindow, l
        bind = $mainMod SHIFT,	right,	movewindow, r
        bind = $mainMod SHIFT,	up,		movewindow, u
        bind = $mainMod SHIFT,	down,	movewindow, d
        bind = $mainMod SHIFT,	h,		movewindow, l
        bind = $mainMod SHIFT,	l,		movewindow, r
        bind = $mainMod SHIFT,	k,		movewindow, u
        bind = $mainMod SHIFT,	j,		movewindow, d
        bind = $mainMod,		left,	movefocus, l
        bind = $mainMod,		right,	movefocus, r
        bind = $mainMod,		up,		movefocus, u
        bind = $mainMod,		down,	movefocus, d
        bind = $mainMod,		h,		movefocus, l
        bind = $mainMod,		l,		movefocus, r
        bind = $mainMod,		k,		movefocus, u
        bind = $mainMod,		j,		movefocus, d
        bind = $mainMod,		1,		workspace, 1
        bind = $mainMod,		2,		workspace, 2
        bind = $mainMod,		3,		workspace, 3
        bind = $mainMod,		4,		workspace, 4
        bind = $mainMod,		5,		workspace, 5
        bind = $mainMod,		6,		workspace, 6
        bind = $mainMod,		7,		workspace, 7
        bind = $mainMod,		8,		workspace, 8
        bind = $mainMod,		9,		workspace, 9
        bind = $mainMod,		0,		workspace, 10
        bind = $mainMod SHIFT,	1,		movetoworkspace, 1
        bind = $mainMod SHIFT,	2,		movetoworkspace, 2
        bind = $mainMod SHIFT,	3,		movetoworkspace, 3
        bind = $mainMod SHIFT,	4,		movetoworkspace, 4
        bind = $mainMod SHIFT,	5,		movetoworkspace, 5
        bind = $mainMod SHIFT,	6,		movetoworkspace, 6
        bind = $mainMod SHIFT,	7,		movetoworkspace, 7
        bind = $mainMod SHIFT,	8,		movetoworkspace, 8
        bind = $mainMod SHIFT,	9,		movetoworkspace, 9
        bind = $mainMod SHIFT,	0,		movetoworkspace, 10
        bind = $mainMod,		mouse_down, workspace, e+1
        bind = $mainMod,		mouse_up,	workspace, e-1
        bindm = $mainMod,		mouse:272,	movewindow
        bindm = $mainMod,		mouse:273,	resizewindow

        monitor=,highres,auto,auto          # Automatic Configuration

        input {
            kb_layout = us
            kb_options=caps:super
            follow_mouse = 1

            touchpad {
                natural_scroll = false
            }

            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }

        gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 3
        }

        animations {
            enabled = yes

            # Define Settings For Animation Bezier Curve
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 0.3, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1

            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsOut, 1, 5, winOut, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = borderangle, 1, 30, liner, loop
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind
        }

        general {
            gaps_in = 4
            gaps_out = 8
            border_size = 3
            col.active_border = rgba(bb9af7ff) rgba(b4f9f8ff) 45deg
            col.inactive_border = rgba(565f89cc) rgba(9aa5cecc) 45deg
            layout = dwindle
            resize_on_border = true
        }

        decoration {
            rounding = 10
            drop_shadow = false

            blur {
                enabled = true
                size = 6
                passes = 3
                new_optimizations = on
                ignore_opacity = on
                xray = true
            }
        }

        exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1        # You Must Have A Polkit
        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # For XDPH
        exec-once = dbus-update-activation-environment --systemd --all # For XDPH
        exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # For XDPH
        exec-once = swww init # Wallpaper Daemon
        exec-once = swaync # Notification Center
        exec-once = waybar # Status Bar
        exec-once = wl-clipboard-history -t # Clipboard
        exec-once = thunar --daemon # File Managers Daemon
        exec-once = $HOME/.config/hypr/hyprdesktop # Ensure Proper Portals Are Loaded
        exec-once = hyprctl setcursor Bibata-Modern-Ice 24 # Set Proper Curser & Size
        exec-once = swww img ~/.config/wallpaper.png
    '';
  };
  programs = {
    kitty = {
      enable = true;
      package = pkgs.kitty;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 16;
      font.package = pkgs.nerdfonts;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 6;
        confirm_os_window_close = 0;
        background_opacity = "0.85";
      };
      extraConfig = ''
          foreground #a9b1d6
          background #1a1b26
          color0 #414868
          color8 #414868
          color1 #f7768e
          color9 #f7768e
          color2  #73daca
          color10 #73daca
          color3  #e0af68
          color11 #e0af68
          color4  #7aa2f7
          color12 #7aa2f7
          color5  #bb9af7
          color13 #bb9af7
          color6  #7dcfff
          color14 #7dcfff
          color7  #c0caf5
          color15 #c0caf5
          cursor #c0caf5
          cursor_text_color #1a1b26
          selection_foreground none
          selection_background #28344a
          url_color #9ece6a
          active_border_color #3d59a1
          inactive_border_color #101014
          bell_border_color #e0af68
          tab_bar_style fade
          tab_fade 1
          active_tab_foreground   #3d59a1
          active_tab_background   #16161e
          active_tab_font_style   bold
          inactive_tab_foreground #787c99
          inactive_tab_background #16161e
          inactive_tab_font_style bold
          tab_bar_background #101014
      '';
    };
    bash = {
      enable = true;
      enableCompletion = true;
      sessionVariables = {
      
      };
      shellAliases = {
        svim="sudo vim";
        ls="lsd";
        ll="lsd -l";
        la="lsd -a";
        lal="lsd -al";
        ".."="cd ..";
      };
    };
    waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [{
	layer = "top";
	position = "top";

	modules-left = [ "hyprland/window" ];
	modules-center = [ "network" "pulseaudio" "cpu" "hyprland/workspaces" "memory" "disk" "clock" ];
	modules-right = [ "custom/notification" "tray" ];
	"hyprland/workspaces" = {
        	format = "{icon}";
        	format-icons = {
            		default = " ";
            		active = " ";
            		urgent = " ";
	};
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
    	};
	"clock" = {
        format = "{: %I:%M %p}";
		tooltip = false;
	};
	"hyprland/window" = {
		max-length = 60;
		separate-outputs = false;
	};
	"memory" = {
		interval = 5;
		format = " {}%";
	};
	"cpu" = {
		interval = 5;
		format = " {usage:2}%";
        tooltip = false;
	};
    "disk" = {
        format = "  {free}/{total}";
        tooltip = true;
    };
    "network" = {
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-ethernet = ": {bandwidthDownOctets} : {bandwidthUpOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
    };
	"tray" = {
		spacing = 12;
	};
    "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
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
        	on-click = "pavucontrol";
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
       		on-click = "task-waybar";
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
      style = ''
	* {
		font-size: 16px;
		font-family: Ubuntu Nerd Font, Font Awesome, sans-serif;
    		font-weight: bold;
	}
	window#waybar {
		    background-color: rgba(26,27,38,0);
    		border-bottom: 1px solid rgba(26,27,38,0);
    		border-radius: 0px;
		    color: #f8f8f2;
	}
	#workspaces {
		    background: linear-gradient(180deg, #414868, #24283b);
    		margin: 5px;
    		padding: 0px 1px;
    		border-radius: 15px;
    		border: 0px;
    		font-style: normal;
    		color: #15161e;
	}
	#workspaces button {
    		padding: 0px 5px;
    		margin: 4px 3px;
    		border-radius: 15px;
    		border: 0px;
    		color: #15161e;
    		background-color: #1a1b26;
    		opacity: 1.0;
    		transition: all 0.3s ease-in-out;
	}
	#workspaces button.active {
    		color: #15161e;
    		background: #7aa2f7;
    		border-radius: 15px;
    		min-width: 40px;
    		transition: all 0.3s ease-in-out;
    		opacity: 1.0;
	}
	#workspaces button:hover {
    		color: #15161e;
    		background: #7aa2f7;
    		border-radius: 15px;
    		opacity: 1.0;
	}
	tooltip {
  		background: #1a1b26;
  		border: 1px solid #7aa2f7;
  		border-radius: 10px;
	}
	tooltip label {
  		color: #c0caf5;
	}
	#window {
    		color: #565f89;
    		background: #1a1b26;
    		border-radius: 0px 15px 50px 0px;
    		margin: 5px 5px 5px 0px;
    		padding: 2px 20px;
	}
	#memory {
    		color: #2ac3de;
    		background: #1a1b26;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#clock {
    		color: #c0caf5;
    		background: #1a1b26;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#cpu {
    		color: #b4f9f8;
    		background: #1a1b26;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#disk {
    		color: #9ece6a;
    		background: #1a1b26;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#battery {
    		color: #f7768e;
    		background: #1a1b26;
    		border-radius: 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#network {
    		color: #ff9e64;
    		background: #1a1b26;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#tray {
    		color: #bb9af7;
    		background: #1a1b26;
    		border-radius: 15px 0px 0px 50px;
    		margin: 5px 0px 5px 5px;
    		padding: 2px 20px;
	}
	#pulseaudio {
    		color: #bb9af7;
    		background: #1a1b26;
    		border-radius: 50px 15px 50px 15px;
    		margin: 5px;
    		padding: 2px 20px;
	}
	#custom-notification {
    		color: #7dcfff;
    		background: #1a1b26;
    		border-radius: 15px 50px 15px 50px;
    		margin: 5px;
    		padding: 2px 20px;
	}
      '';
    };
  };
}
