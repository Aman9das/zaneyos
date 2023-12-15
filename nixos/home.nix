{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.zaney = {

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
  home.file.".vimrc" = {
    source = ../configfiles/.vimrc;
    recursive = true;
  };
  home.file.".config/tofi/config" = {
    source = ../configfiles/tofi/config;
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
  home.file.".config/hypr/hyprland.conf" = {
    source = ../configfiles/hypr/hyprland.conf;
    recursive = true;
  };
  home.file.".config/hypr/keybindings.conf" = {
    source = ../configfiles/hypr/keybindings.conf;
    recursive = true;
  };
  home.file.".config/hypr/theme.conf" = {
    source = ../configfiles/hypr/theme.conf;
    recursive = true;
  };
  home.file.".config/hypr/animations.conf" = {
    source = ../configfiles/hypr/animations.conf;
    recursive = true;
  };
  home.file.".config/hypr/autostart.conf" = {
    source = ../configfiles/hypr/autostart.conf;
    recursive = true;
  };
  home.file.".config/zaney-stinger.mov" = {
    source = ../configfiles/zaney-stinger.mov;
    recursive = true;
  };
  home.file.".local/share/fonts/UniSans-Heavy.otf" = {
    source = ../configfiles/UniSans-Heavy.otf;
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
  programs = {
    kitty = {
      enable = true;
      package = pkgs.kitty;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 16;
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
        sv="sudo vim";
	v="vim";
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
  };
}
