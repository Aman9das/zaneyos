{
  pkgs,
  config,
  lib,
  inputs,
  host,
  ...
}: let
  # theme = config.colorScheme.palette;
  wallpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
  inherit
    (import ../../../hosts/${host}/options.nix)
    browser
    cpuType
    gpuType
    wallpaperDir
    borderAnim
    theKBDLayout
    terminal
    theSecondKBDLayout
    theKBDVariant
    sdl-videodriver
    extraMonitorSettings
    ;

  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  hyprscroller = pkgs.callPackage ./hyprscroller.nix {
    inherit hyprland;
    hyprlandPlugins = plugins;
  };
in
  with lib; {
    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland;
      xwayland.enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };
      plugins = [
        # hyprplugins.hyprtrails
        hyprscroller
        plugins.hyprexpo
      ];
      extraConfig = let
        modifier = "SUPER";
      in
        concatStrings [
          ''
            monitor=,preferred,auto,1
            ${extraMonitorSettings}
            general {
              gaps_in = 2
              gaps_out = 4
              border_size = 2
              col.active_border = rgba(3584e480)
              col.inactive_border = rgba(30303080)
              layout = scroller
              resize_on_border = false
            }

            input {
              kb_layout = ${theKBDLayout}, ${theSecondKBDLayout}
             kb_options = grp:alt_shift_toggle
              kb_options=caps:swapescape
             follow_mouse = 1
              touchpad {
                natural_scroll = true
              }
              sensitivity = 0.8 # -1.0 - 1.0, 0 means no modification.
              accel_profile = flat
            }
            env = NIXOS_OZONE_WL, 1
            env = NIXPKGS_ALLOW_UNFREE, 1
            env = XDG_CURRENT_DESKTOP, Hyprland
            env = XDG_SESSION_TYPE, wayland
            env = XDG_SESSION_DESKTOP, Hyprland
            env = GDK_BACKEND, wayland
            env = CLUTTER_BACKEND, wayland
            env = SDL_VIDEODRIVER, ${sdl-videodriver}
            env = QT_QPA_PLATFORM, wayland
            env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
            env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
            env = WLR_NO_HARDWARE_CURSORS,1
            env = MOZ_ENABLE_WAYLAND, 1
            ${
              if cpuType == "vm"
              then ''
                env = WLR_NO_HARDWARE_CURSORS,1
                env = WLR_RENDERER_ALLOW_SOFTWARE,1
              ''
              else ''
              ''
            }
            ${
              if gpuType == "nvidia"
              then ''
                env = WLR_NO_HARDWARE_CURSORS,1
              ''
              else ''
              ''
            }
            gestures {
             workspace_swipe = true
              workspace_swipe_fingers = 3
              # workspace_swipe_forever = true
              # workspace_swipe_direction_lock = false
            }
            misc {
              mouse_move_enables_dpms = true
              key_press_enables_dpms = false
              disable_hyprland_logo = true
              disable_splash_rendering = true
              focus_on_activate = true
            }
            rules {
              layerrule = animation popin 80%, rofi$
              windowrule = tile, ^(Vivaldi-stable)$
              windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$
              windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
              }
            binds {
                allow_workspace_cycles = true
              }
            animations {
              enabled = yes
              bezier = wind, 0.05, 0.9, 0.1, 1.05
              bezier = winIn, 0.1, 1.1, 0.1, 1.1
              bezier = winOut, 0.3, -0.3, 0, 1
              bezier = liner, 1, 1, 1, 1
              animation = windows, 1, 6, wind, slide
              animation = windowsIn, 1, 6, winIn, slide
              animation = windowsOut, 1, 5, winOut, slide
              animation = windowsMove, 1, 5, wind, slide
              animation = border, 1, 1, liner
              animation = layers, 1, 1, default, fade
              ${
              if borderAnim == true
              then ''
                animation = borderangle, 1, 30, liner, loop
              ''
              else ''
              ''
            }
              animation = fade, 1, 10, default
              animation = workspaces, 1, 5, wind, slidevert
            }
            decoration {
              rounding = 10
              drop_shadow = false
            }
            plugin {
              scroller {
                column_default_width = twothirds
                focus_wrap = false
              }
            }
            exec-once = $POLKIT_BIN
            exec-once = dbus-update-activation-environment --systemd --all
            exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
            exec-once = ${wallpaper}
            exec-once = waybar
            exec-once = swaync
            exec-once = fusuma
            exec-once = nm-applet --indicator
            exec-once = hypridle
            exec-once = wl-paste --type text --watch cliphist store #Stores only text data
            exec-once = wl-paste --type image --watch cliphist store #Stores only image data
            dwindle {
              pseudotile = true
              preserve_split = true
              no_gaps_when_only = 2
            }
            master {
              new_is_master = true
            }
            bind = ${modifier},SUPER_L,exec,rofi-launcher
            bind = ${modifier}, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
            bind = ${modifier},Return,exec,${terminal}
            bind = ${modifier}SHIFT,Return,exec,rofi-launcher
            bind = ${modifier}SHIFT,Q,exec,rofi-exit
            bind = ${modifier}SHIFT,W,exec,web-search
            bind = ${modifier},N,exec,swaync-client -t
            ${
              if browser == "google-chrome"
              then ''
                bind = ${modifier},W,exec,google-chrome-stable
              ''
              else ''
                bind = ${modifier},W,exec,${browser}
              ''
            }
            bind = ${modifier},E,exec,emopicker9000
            bind = ${modifier},T,exec,nemo
            bind = ${modifier},Q,killactive,
            # bind = ${modifier},P,pseudo,
            bind = ${modifier},F,scroller:cyclesize,1
            bind = ${modifier},M,fullscreen,1
            bind = ${modifier}SHIFT,F,togglefloating,
            bind = ${modifier}SHIFT,M,fullscreen,0
            # bind = ${modifier}SHIFT,C,exit,
            bind = ${modifier}SHIFT,I,scroller:admitwindow,
            bind = ${modifier}SHIFT,O,scroller:expelwindow,
            bind = ${modifier}SHIFT,left,scroller:movewindow,l
            bind = ${modifier}SHIFT,right,scroller:movewindow,r
            bind = ${modifier}SHIFT,up,scroller:movewindow,u
            bind = ${modifier}SHIFT,down,scroller:movewindow,d
            bind = ${modifier}SHIFT,h,scroller:movewindow,l
            bind = ${modifier}SHIFT,l,scroller:movewindow,r
            bind = ${modifier}SHIFT,k,scroller:movewindow,u
            bind = ${modifier}SHIFT,j,scroller:movewindow,d
            bind = ${modifier},left,scroller:movefocus,l
            bind = ${modifier},right,scroller:movefocus,r
            bind = ${modifier},up,scroller:movefocus,u
            bind = ${modifier},down,scroller:movefocus,d
            bind = ${modifier},h,scroller:movefocus,l
            bind = ${modifier},l,scroller:movefocus,r
            bind = ${modifier},k,scroller:movefocus,u
            bind = ${modifier},j,scroller:movefocus,d
            bind = ${modifier},1,workspace,1
            bind = ${modifier},2,workspace,2
            bind = ${modifier},3,workspace,3
            bind = ${modifier},4,workspace,4
            bind = ${modifier},5,workspace,5
            bind = ${modifier},6,workspace,6
            bind = ${modifier},7,workspace,7
            bind = ${modifier},8,workspace,8
            bind = ${modifier},9,workspace,9
            bind = ${modifier},0,workspace,10
            bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
            bind = ${modifier},SPACE,togglespecialworkspace
            bind = ${modifier}SHIFT,1,movetoworkspace,1
            bind = ${modifier}SHIFT,2,movetoworkspace,2
            bind = ${modifier}SHIFT,3,movetoworkspace,3
            bind = ${modifier}SHIFT,4,movetoworkspace,4
            bind = ${modifier}SHIFT,5,movetoworkspace,5
            bind = ${modifier}SHIFT,6,movetoworkspace,6
            bind = ${modifier}SHIFT,7,movetoworkspace,7
            bind = ${modifier}SHIFT,8,movetoworkspace,8
            bind = ${modifier}SHIFT,9,movetoworkspace,9
            bind = ${modifier}SHIFT,0,movetoworkspace,10
            bind = ${modifier}CONTROL,right,workspace,e+1
            bind = ${modifier}CONTROL,left,workspace,e-1
            bind = ${modifier},mouse_down,workspace, e+1
            bind = ${modifier},mouse_up,workspace, e-1
            bindm = ${modifier},mouse:272,movewindow
            bindm = ${modifier},mouse:273,resizewindow
            bind = ${modifier},Tab,workspace,previous
            bind = ${modifier},Prior,workspace,e-1
            bind = ${modifier},Next,workspace,e+1
            bind = ALT,Tab,cyclenext
            bind = ALT,Tab,bringactivetotop
            bind = ,Print,exec,rofi-shot
            bind = SHIFT, Print, exec, sleep 0.5 && grimblast --freeze --notify copysave output $HOME/Pictures/Screenshots/$(date +%Y-%m-%d-T-%H-%M-%S).png
            bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            binde = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
            bind = ,XF86AudioPlay, exec, playerctl play-pause
            bind = ,XF86AudioPause, exec, playerctl play-pause
            bind = ,XF86AudioNext, exec, playerctl next
            bind = ,XF86AudioPrev, exec, playerctl previous
            bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
            bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
          ''
        ];
    };
  }
