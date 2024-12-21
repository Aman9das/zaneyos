{
  pkgs,
  pkgs-unstable,
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

in
with lib;
{
  home.packages = with pkgs; [ hyprnome ];
  wayland.windowManager.hyprland = {
    enable = true;
    # package = hyprland;
    xwayland.enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };
    plugins = with pkgs.hyprlandPlugins; [
      # hyprscroller
    ];
    settings = {
      monitor = ",preferred,auto,1";

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(57e389c0)";
        "col.inactive_border" = "rgba(b5b8b680)";
        layout = "scroller";
        resize_on_border = true;
        resize_corner = 3;
      };

      input = {
        kb_layout = "${theKBDLayout}, ${theSecondKBDLayout}";
        kb_options = [
          "grp:alt_shift_toggle"
          "caps:escape"
        ];
        follow_mouse = 2;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
          drag_lock = true;
          scroll_factor = 0.75;
        };
        sensitivity = 0.8;
        accel_profile = "flat";
      };

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland"
        "CLUTTER_BACKEND, wayland"
        "SDL_VIDEODRIVER, ${sdl-videodriver}"
        "QT_QPA_PLATFORM, wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        # "WLR_NO_HARDWARE_CURSORS,1"
        "MOZ_ENABLE_WAYLAND, 1"
        (
          if cpuType == "vm" then
            "WLR_NO_HARDWARE_CURSORS,1" "WLR_RENDERER_ALLOW_SOFTWARE,1"
          else
            "WLR_NO_HARDWARE_CURSORS,0"
        )
        (if gpuType == "nvidia" then "WLR_NO_HARDWARE_CURSORS,1" else "WLR_NO_HARDWARE_CURSORS,0")
      ];

      gestures = {
        workspace_swipe = false;
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.6;
        # workspace_swipe_forever = true
        # workspace_swipe_direction_lock = false
      };

      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        vfr = true;
      };

      rules = {
        layerrule = [
          "blur, waybar"
          # "animation popin 80%, rofi$"
        ];
        windowrule = [
          "tile, ^(Vivaldi-stable)$"

          "workspace current,title:MainPicker"
          "workspace current,.blueman-manager-wrapped"
          "workspace current,xdg-desktop-portal-gtk"
          "workspace current,thunderbird"
          "workspace current,org.qutebrowser.qutebrowser"
          "workspace current,org.gnome.Loupe"
          "workspace current,fusuma"
          "workspace current,polkit-gnome-authentication-agent-1"

          "maximize, spicy"
          "fullscreen,^(waydroid.*)"
          "float, org.gnome.FileRoller"
        ];
        windowrulev2 = [
          "fullscreen,class:(Waydroid),title:(Waydroid)"

          "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
          "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        ];
      };

      binds = {
        # allow_workspace_cycles = true
      };

      cursor = {
        # hotspot_padding = 4
        inactive_timeout = 30;
        # no_warps = true
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "layers, 1, 0.3, default, fade"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind, slidevert"
        ];
      };

      decoration = {
        rounding = 10;
        # drop_shadow = false;
        dim_inactive = true;
      };

      plugin = {
        scroller = {
          focus_wrap = false;
          column_widths = "onehalf one onethird twothirds";
        };
      };

      exec-once = [
        "hyprctl dispatch workspace 5000000"
        "[workspace current silent] $POLKIT_BIN"
        "[workspace current silent] dbus-update-activation-environment --systemd --all"
        "[workspace current silent] systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "[workspace current silent] ${wallpaper}"
        "[pin] waybar"
        "[workspace current silent] swaync"
        # "[workspace current silent] scroller-fitsize"
        "[workspace current silent] nm-applet --indicator"
        "[workspace current silent] hypridle"
        "[workspace current silent] wl-paste --type text --watch cliphist store" # Stores only text data
        "[workspace current silent] wl-paste --type image --watch cliphist store" # Stores only image data
        "[workspace current silent] ferdium"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        # no_gaps_when_only = 2;
      };

      master = {
        # new_is_master = true;
      };

    };
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
          ${extraMonitorSettings}

          bindr = ${modifier},SUPER_L,exec,rofi-launcher
          bind = ${modifier}, V, exec, cliphist list | rofi -dmenu -p Clipboard | cliphist decode | wl-copy
          bind = ${modifier}SHIFT,Q,exec,rofi-exit
          bind = ${modifier},N,exec,swaync-client -t
          # bind = ${modifier},P,pseudo,
          bind = ${modifier},Q,killactive,


          bind = ${modifier}SHIFT,F,fullscreen,0
          bind = ${modifier}CONTROL,F,togglefloating
          bind = ${modifier}SHIFT,C,exit,

          bindr = ${modifier},left, movefocus,l
          bindr = ${modifier},right, movefocus,r
          bindr = ${modifier},up, movefocus,u
          bindr = ${modifier},down, movefocus,d

          bind = ${modifier}SHIFT,left, movewindow,l
          bind = ${modifier}SHIFT,right, movewindow,r
          bind = ${modifier}SHIFT,up, movewindow,u
          bind = ${modifier}SHIFT,down, movewindow,d


          # bind = ${modifier},F,scroller:cyclesize,1
          # bind = ${modifier},bracketleft,scroller:setmode, col
          # bind = ${modifier},bracketleft,scroller:admitwindow,
          # bind = ${modifier},bracketleft,scroller:fitsize, all
          # bind = ${modifier},bracketleft,scroller:setmode, row
          # bind = ${modifier},bracketright,scroller:setmode, col
          # bind = ${modifier},bracketright,scroller:expelwindow,
          # bind = ${modifier},bracketright,scroller:movefocus, l
          # bind = ${modifier},bracketright,scroller:fitsize, all
          # bind = ${modifier},bracketright,scroller:movefocus, r
          # bind = ${modifier},bracketright,scroller:setmode, row
          #
          # bindr = ${modifier},left,scroller:movefocus,l
          # bindr = ${modifier},right,scroller:movefocus,r
          # bindr = ${modifier},up, scroller:movefocus,u
          # bindr = ${modifier},down,scroller:movefocus,d
          #
          # bind = ${modifier}SHIFT,left,scroller:movewindow,l
          # bind = ${modifier}SHIFT,right,scroller:movewindow,r
          # bind = ${modifier}SHIFT,up,scroller:movewindow,u
          # bind = ${modifier}SHIFT,down,scroller:movewindow,d
          #
          # bind = ${modifier}ALT,left,scroller:alignwindow,l
          # bind = ${modifier}ALT,right,scroller:alignwindow,r
          #

          binde = ${modifier}CONTROL,left, resizeactive, -10 0
          binde = ${modifier}CONTROL,right, resizeactive, 10 0
          binde = ${modifier}CONTROL,up, resizeactive, 0 -10
          # bindr = ${modifier}CONTROL,up,scroller:setmode, col
          # bindr = ${modifier}CONTROL,up,scroller:fitsize, all
          # bindr = ${modifier}CONTROL,up,scroller:setmode, row
          binde = ${modifier}CONTROL,down, resizeactive, 0 10
          # bindr = ${modifier}CONTROL,down,scroller:setmode, col
          # bindr = ${modifier}CONTROL,down,scroller:fitsize, all
          # bindr = ${modifier}CONTROL,down,scroller:setmode, row
          #
          # bind = ${modifier},h,scroller:movefocus,l
          # bind = ${modifier},l,scroller:movefocus,r
          # bind = ${modifier}SHIFT,h,scroller:movewindow,l
          # bind = ${modifier}SHIFT,l,scroller:movewindow,r

          # bind = ${modifier},SPACE,scroller:toggleoverview

          bind = ${modifier},k,exec, hyprnome --previous
          bind = ${modifier},j,exec, hyprnome
          bind = ${modifier}SHIFT,k,exec, hyprnome --previous --move
          bind = ${modifier}SHIFT,j,exec, hyprnome --move

          bind = ${modifier}, 1, exec, hyprnome --previous
          bind = ${modifier}, 2, exec, hyprnome
          bind = ${modifier}SHIFT, 1, exec, hyprnome --previous --move
          bind = ${modifier}SHIFT, 2, exec, hyprnome --move

          bind = ${modifier},0,togglespecialworkspace
          bind = ${modifier}SHIFT,0,movetoworkspace,special
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
          bind = ${modifier},period,exec, rofi -show emoji
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
