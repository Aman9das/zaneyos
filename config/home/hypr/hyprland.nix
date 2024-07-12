{
  pkgs,
  config,
  lib,
  inputs,
  host,
  ...
}:
let
  # theme = config.colorScheme.palette;
  wallpaper = "${pkgs.hyprpaper}/bin/hyprpaper";
  inherit (import ../../../hosts/${host}/options.nix)
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
  hyprscroller = inputs.hyprscroller.packages.${pkgs.system}.default;
in
with lib;
{
  home.packages = with pkgs; [ hyprnome ];
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
      # plugins.hyprexpo
    ];
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
          monitor=,preferred,auto,1
          ${extraMonitorSettings}
          general {
            gaps_in = 2
            gaps_out = 4,16
            border_size = 2
            col.active_border = rgba(57e389c0)
            col.inactive_border = rgba(b5b8b680)
            layout = scroller
            resize_on_border = true
            resize_corner = 3
          }

          input {
            kb_layout = ${theKBDLayout}, ${theSecondKBDLayout}
            kb_options = grp:alt_shift_toggle
            kb_options=caps:swapescape
            follow_mouse = 2
            # mouse_refocus = false
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
          # env = WLR_NO_HARDWARE_CURSORS,1
          env = MOZ_ENABLE_WAYLAND, 1
          ${
            if cpuType == "vm" then
              ''
                env = WLR_NO_HARDWARE_CURSORS,1
                env = WLR_RENDERER_ALLOW_SOFTWARE,1
              ''
            else
              ""
          }
          ${
            if gpuType == "nvidia" then
              ''
                env = WLR_NO_HARDWARE_CURSORS,1
              ''
            else
              ""
          }
          gestures {
            # workspace_swipe = true
            workspace_swipe_fingers = 3
            workspace_swipe_cancel_ratio = 0.6
            # workspace_swipe_forever = true
            # workspace_swipe_direction_lock = false
          }
          misc {
            mouse_move_enables_dpms = true
            key_press_enables_dpms = false
            disable_hyprland_logo = true
            disable_splash_rendering = true
            focus_on_activate = true
            vfr = true
          }
          rules {
            layerrule = blur, waybar
            layerrule = animation popin 80%, rofi$
            windowrule = tile, ^(Vivaldi-stable)$

            windowrule = workspace current,title:MainPicker
            windowrule = workspace current,.blueman-manager-wrapped
            windowrule = workspace current,xdg-desktop-portal-gtk
            windowrule = workspace current,thunderbird
            windowrule = workspace current,org.qutebrowser.qutebrowser
            windowrule = maximize,thunderbird
            windowrule = workspace current,org.gnome.Loupe
            windowrule = workspace current,fusuma
            windowrule = workspace current,polkit-gnome-authentication-agent-1
            windowrule = maximize,ferdium
            windowrule = maximize,Logseq
            windowrule = maximize,org.libretro.RetroArch
            windowrule = maximize,heroic
            windowrule = fullscreen,spicy
            windowrulev2 = fullscreen,class:(Waydroid),title:(Waydroid)

            windowrule = float, org.gnome.FileRoller

            windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$
            windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
            }
          binds {
              # allow_workspace_cycles = true
            }
          cursor {
              # hotspot_padding = 4
              inactive_timeout = 30
              # no_warps = true
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
              if borderAnim == true then
                ''
                  animation = borderangle, 1, 30, liner, loop
                ''
              else
                ""
            }
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind, slidevert
          }
          decoration {
            rounding = 10
            drop_shadow = false
            # blur = false
          }
          plugin {
            scroller {
              # column_default_width = onehalf
              focus_wrap = false
            }
          }
          exec-once = hyprctl dispatch workspace 5000000

          exec-once = [workspace current silent] $POLKIT_BIN
          exec-once = [workspace current silent] dbus-update-activation-environment --systemd --all
          exec-once = [workspace current silent] systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = [workspace current silent] ${wallpaper}
          exec-once = [pin] waybar
          exec-once = [workspace current silent] swaync
          exec-once = [workspace current silent] scroller-fitsize
          exec-once = [workspace current silent] nm-applet --indicator
          exec-once = [workspace current silent] hypridle
          exec-once = [workspace current silent] wl-paste --type text --watch cliphist store #Stores only text data
          exec-once = [workspace current silent] wl-paste --type image --watch cliphist store #Stores only image data
          exec-once = [workspace current silent] ferdium

          dwindle {
            pseudotile = true
            preserve_split = true
            no_gaps_when_only = 2
          }
          master {
            # new_is_master = true
          }

          bindr = ${modifier},SUPER_L,exec,rofi-launcher
          bind = ${modifier}, V, exec, cliphist list | rofi -dmenu -p Clipboard | cliphist decode | wl-copy
          bind = ${modifier}SHIFT,Q,exec,rofi-exit
          bind = ${modifier},N,exec,swaync-client -t
          # bind = ${modifier},P,pseudo,
          bind = ${modifier},Q,killactive,


          bind = ${modifier},Z,scroller:cyclesize,1
          bind = ${modifier}SHIFT,Z,fullscreen,0
          bind = ${modifier}CONTROL,F,scroller:fitsize, all
          bind = ${modifier},F,fullscreen,1
          bind = ${modifier}SHIFT,F,togglefloating
          bind = ${modifier}SHIFT,C,exit,

          bind = ${modifier},bracketleft,scroller:setmode, col
          bind = ${modifier},bracketleft,scroller:admitwindow,
          bind = ${modifier},bracketleft,scroller:fitsize, all
          bind = ${modifier},bracketleft,scroller:setmode, row
          bind = ${modifier},bracketright,scroller:setmode, col
          bind = ${modifier},bracketright,scroller:expelwindow,
          bind = ${modifier},bracketright,scroller:movefocus, l
          bind = ${modifier},bracketright,scroller:fitsize, all
          bind = ${modifier},bracketright,scroller:movefocus, r
          bind = ${modifier},bracketright,scroller:setmode, row

          bindr = ${modifier},left,scroller:movefocus,l
          bindr = ${modifier},right,scroller:movefocus,r
          bindr = ${modifier},up, scroller:movefocus,u
          bindr = ${modifier},down,scroller:movefocus,d

          bind = ${modifier}SHIFT,left,scroller:movewindow,l
          bind = ${modifier}SHIFT,right,scroller:movewindow,r
          bind = ${modifier}SHIFT,up,scroller:movewindow,u
          bind = ${modifier}SHIFT,down,scroller:movewindow,d

          bind = ${modifier}ALT,left,scroller:alignwindow,l
          bind = ${modifier}ALT,right,scroller:alignwindow,r

          binde = ${modifier}CONTROL,left, resizeactive, -10 0
          binde = ${modifier}CONTROL,right, resizeactive, 10 0
          binde = ${modifier}CONTROL,up, resizeactive, 0 -10
          bindr = ${modifier}CONTROL,up,scroller:setmode, col
          bindr = ${modifier}CONTROL,up,scroller:fitsize, all
          bindr = ${modifier}CONTROL,up,scroller:setmode, row
          binde = ${modifier}CONTROL,down, resizeactive, 0 10
          bindr = ${modifier}CONTROL,down,scroller:setmode, col
          bindr = ${modifier}CONTROL,down,scroller:fitsize, all
          bindr = ${modifier}CONTROL,down,scroller:setmode, row

          bind = ${modifier},h,scroller:movefocus,l
          bind = ${modifier},l,scroller:movefocus,r
          bind = ${modifier},k,exec, hyprnome --previous
          bind = ${modifier},j,exec, hyprnome
          bind = ${modifier}SHIFT,h,scroller:movewindow,l
          bind = ${modifier}SHIFT,l,scroller:movewindow,r
          bind = ${modifier}SHIFT,k,exec, hyprnome --previous --move
          bind = ${modifier}SHIFT,j,exec, hyprnome --move

          bind = ${modifier}, 1, exec, hyprnome --previous
          bind = ${modifier}, 2, exec, hyprnome
          bind = ${modifier}SHIFT, 1, exec, hyprnome --previous --move
          bind = ${modifier}SHIFT, 2, exec, hyprnome --move

          bind = ${modifier},0,togglespecialworkspace
          bind = ${modifier}SHIFT,0,movetoworkspace,special
          bind = ${modifier},SPACE,scroller:toggleoverview
          bind = ${modifier}SHIFT,SPACE,movetoworkspace,current

          bind = ${modifier},mouse_down,exec, hyprnome
          bind = ${modifier},mouse_up,exec, hyprnome --previous
          bindm = ${modifier},mouse:272,movewindow
          bindm = ${modifier},mouse:273,resizewindow
          bindm = ${modifier}SHIFT,mouse:272,resizewindow

          bind = ${modifier},Tab,exec, hyprnome --cycle
          bind = ${modifier}SHIFT,Tab,exec, hyprnome --previous --cycle

          bind = ${modifier},Prior,exec, hyprnome --previous
          bind = ${modifier},Next,exec, hyprnome
          bind = ${modifier}SHIFT,Prior,exec, hyprnome --previous --move
          bind = ${modifier}SHIFT,Next,exec, hyprnome --move

          bind = ALT,Tab, cyclenext,
          bind = ALT,Tab, bringactivetotop,
          bind = ALT SHIFT,Tab, cyclenext, prev
          bind = ALT SHIFT,Tab, bringactivetotop,

          bind = ${modifier},Return,exec,${terminal}
          bind = ${modifier},T,exec,${terminal}
          bind = ${modifier},W,exec, qutebrowser
          bind = ${modifier},E,exec, nemo
          bind = ${modifier}SHIFT,E,exec, rofi -show emoji
          bind = ${modifier},equal,exec, rofi -show calc
          bind = ${modifier},B,exec, bwm
          # bind = ${modifier},Y,exec, vivaldi
          # bind = ${modifier}SHIFT,W,exec,web-search

          bind = ,Print,exec,rofi-shot
          bind = SHIFT, Print, exec, sleep 0.5 && grimblast --freeze --notify copysave output $HOME/Pictures/Screenshots/$(date +%Y-%m-%d-T-%H-%M-%S).png
          bindel = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bindel = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindl = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          bindl = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
          bindl = ,XF86AudioPlay, exec, playerctl play-pause
          bindl = ,XF86AudioPause, exec, playerctl play-pause
          bindl = ,XF86AudioNext, exec, playerctl next
          bindl = ,XF86AudioPrev, exec, playerctl previous
          bindel = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
          bindel = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
        ''
      ];
  };
}
