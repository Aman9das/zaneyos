{ pkgs, config, browser, ... }:

{
    home.file.".config/hypr/hyprland.conf".text = ''

# monitor=[monitor-name],[resolution@framerate],[pos-x,y],[scale factor],transform,[rotation]
# Rotation Degrees Shorthand
# normal (no transforms) -> 0
# 90 degrees -> 1
# 180 degrees -> 2
# 270 degrees -> 3
# flipped -> 4
# flipped + 90 degrees -> 5
# flipped + 180 degrees -> 6
# flipped + 270 degrees -> 7
monitor=,highres,auto,1          # Automatic Configuration

windowrule = float, ^(steam)$
windowrule = center, ^(steam)$
windowrule = size 1080 900, ^(steam)$

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

# Ensure Mouse or Keyboard Inputs Turn On Displays
misc {
    mouse_move_enables_dpms = true
    key_press_enables_dpms = false
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

# Set Environment Variables
env = NIXOS_OZONE_WL, 1
env = NIXPKGS_ALLOW_UNFREE, 1
env = XDG_CURRENT_DESKTOP, Hyprland
env = XDG_SESSION_TYPE, wayland
env = XDG_SESSION_DESKTOP, Hyprland
env = GDK_BACKEND, wayland
env = CLUTTER_BACKEND, wayland
env = SDL_VIDEODRIVER, x11
env = XCURSOR_SIZE, 24
env = XCURSOR_THEME, Bibata-Modern-Ice
env = QT_QPA_PLATFORM, wayland
env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
env = MOZ_ENABLE_WAYLAND, 1
#env = WLR_NO_HARDWARE_CURSORS,1
#env = WLR_RENDERER_ALLOW_SOFTWARE,1

exec-once = $POLKIT_BIN
exec-once = dbus-update-activation-environment --systemd --all
exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = hyprctl setcursor Bibata-Modern-Ice 24
exec-once = swww init
exec-once = waybar
exec-once = swaync
exec-once = wallsetter
exec-once = swayidle -w timeout 150 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'

$mainMod = SUPER
# Sound Control Keybinds
bind = , XF86AudioRaiseVolume,			exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume,			exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute,				    exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
bind = , XF86AudioMicMute,			    exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
# Brightness Control Keybinds
bind = , XF86MonBrightnessDown, 		exec, brightnessctl set 5%-
bind = , XF86MonBrightnessUp,   		exec, brightnessctl set +5%
# System Application Keybinds
bind = $mainMod,		Return,	        exec, kitty
bind = $mainMod SHIFT,	Return,	        exec, rofi -show drun
bind = $mainMod SHIFT,	W,		        exec, kitty -e amfora
bind = $mainMod SHIFT,	S,		        exec, web-search
bind = $mainMod,		W,		        exec, ${browser}
bind = $mainMod,		E,		        exec, emopicker9000
bind = $mainMod,		S,		        exec, grim -g "$(slurp)"
bind = $mainMod,		D,		        exec, discord
bind = $mainMod,		O,		        exec, obs
bind = $mainMod,		G,		        exec, gimp
bind = $mainMod SHIFT,	G,		        exec, godot4
bind = $mainMod,		T,		        exec, thunar
bind = $mainMod,		M,		        exec, ario
# OBS Global Keybinds
bind = ALT,			    F1,		        pass, ^(com\.obsproject\.Studio)$
bind = ALT,			    F2,		        pass, ^(com\.obsproject\.Studio)$
bind = ALT,			    F3,		        pass, ^(com\.obsproject\.Studio)$
bind = ALT,			    F4,		        pass, ^(com\.obsproject\.Studio)$
bind = ALT,			    F5,		        pass, ^(com\.obsproject\.Studio)$
# Hyprland Keybinds
bind = $mainMod,		Q,		        killactive,
bind = $mainMod,		P,		        pseudo, # dwindle
bind = $mainMod SHIFT,	I,		        togglesplit, # dwindle
bind = $mainMod,	    F,		        fullscreen,
bind = $mainMod SHIFT,	F,		        togglefloating,
bind = $mainMod SHIFT,	C,		        exit,
# Move window with mainMod + shift + arrow keys
bind = $mainMod SHIFT,	left,			movewindow, l
bind = $mainMod SHIFT,	right,			movewindow, r
bind = $mainMod SHIFT,	up,			    movewindow, u
bind = $mainMod SHIFT,	down,			movewindow, d
bind = $mainMod SHIFT,	h,			    movewindow, l
bind = $mainMod SHIFT,	l,			    movewindow, r
bind = $mainMod SHIFT,	k,			    movewindow, u
bind = $mainMod SHIFT,	j,			    movewindow, d
# Move focus with mainMod + arrow keys
bind = $mainMod,		left,		    movefocus, l
bind = $mainMod,		right,		    movefocus, r
bind = $mainMod,		up,		        movefocus, u
bind = $mainMod,		down,		    movefocus, d
bind = $mainMod,		h,		        movefocus, l
bind = $mainMod,		l,		        movefocus, r
bind = $mainMod,		k,		        movefocus, u
bind = $mainMod,		j,		        movefocus, d
# Switch workspaces with mainMod + [0-6]
bind = $mainMod,		1,		        workspace, 1
bind = $mainMod,		2,		        workspace, 2
bind = $mainMod,		3,		        workspace, 3
bind = $mainMod,		4,		        workspace, 4
bind = $mainMod,		5,		        workspace, 5
bind = $mainMod,		6,		        workspace, 6
bind = $mainMod,		7,		        workspace, 7
bind = $mainMod,		8,		        workspace, 8
bind = $mainMod,		9,		        workspace, 9
bind = $mainMod,		0,		        workspace, 10
# Move active window to a workspace with mainMod + SHIFT + [0-6]
bind = $mainMod SHIFT,	1,		        movetoworkspace, 1
bind = $mainMod SHIFT,	2,		        movetoworkspace, 2
bind = $mainMod SHIFT,	3,		        movetoworkspace, 3
bind = $mainMod SHIFT,	4,		        movetoworkspace, 4
bind = $mainMod SHIFT,	5,		        movetoworkspace, 5
bind = $mainMod SHIFT,	6,		        movetoworkspace, 6
bind = $mainMod SHIFT,	7,		        movetoworkspace, 7
bind = $mainMod SHIFT,	8,		        movetoworkspace, 8
bind = $mainMod SHIFT,	9,		        movetoworkspace, 9
bind = $mainMod SHIFT,	0,		        movetoworkspace, 10
# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod,		mouse_down,     workspace, e+1
bind = $mainMod,		mouse_up,	    workspace, e-1
# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod,		mouse:272,	    movewindow
bindm = $mainMod,		mouse:273,	    resizewindow

dwindle {
    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # you probably want this
}

master {
    new_is_master = true
}

general {
    gaps_in = 4
    gaps_out = 8
    border_size = 3
    col.active_border = rgba(${config.colorScheme.colors.base0C}ff) rgba(${config.colorScheme.colors.base0D}ff) 45deg
    col.inactive_border = rgba(${config.colorScheme.colors.base00}cc) rgba(${config.colorScheme.colors.base01}cc) 45deg
    layout = dwindle
    resize_on_border = true
}

decoration {
    rounding = 10
    drop_shadow = false

    blur {
        enabled = true
        size = 5
        passes = 3
        new_optimizations = on
        ignore_opacity = on
    }
}

    '';
}
