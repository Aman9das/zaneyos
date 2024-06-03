{
  pkgs,
  config,
  ...
}: let
  # palette = config.colorScheme.palette;
in {
  home.file.".config/swaync/config.json".text = ''
        {
            "$schema": "/etc/xdg/swaync/configSchema.json",
            "positionX": "right",
            "positionY": "top",
            "control-center-margin-top": 10,
            "control-center-margin-bottom": 10,
            "control-center-margin-right": 10,
            "control-center-margin-left": 10,
            "notification-icon-size": 64,
            "notification-body-image-height": 100,
            "notification-body-image-width": 200,
            "timeout": 10,
            "timeout-low": 5,
            "timeout-critical": 0,
            "fit-to-screen": false,
            "control-center-width": 500,
            "control-center-height": 1025,
            "notification-window-width": 500,
            "keyboard-shortcuts": true,
            "image-visibility": "when-available",
            "transition-time": 200,
            "hide-on-clear": false,
            "hide-on-action": true,
            "script-fail-notify": true,
            "widgets": [
                "title",
                "buttons-grid",
                "mpris",
                "volume",
                "backlight",
                "dnd",
                "notifications"
            ],
            "widget-config": {
                "title": {
                    "text": "Notification Center",
                    "clear-all-button": true,
                    "button-text": "󰆴 Clear All"
                },
                "dnd": {
                    "text": "Do Not Disturb"
                },
                "label": {
                    "max-lines": 1,
                    "text": "Notification Center"
                },
                "mpris": {
                    "image-size": 96,
                    "image-radius": 7
                },
                "volume": {
                    "label": "󰕾"
                },
                "backlight": {
                    "label": "󰃟"
                },
                "buttons-grid": {
                    "actions": [
                        {
                            "label": "󰐥",
                            "command": "sh -c 'exit_apps && sleep 0.1 && systemctl poweroff'"
                        },
                        {
                            "label": "󰜉",
                            "command": "sh -c 'exit_apps && sleep 0.1 && systemctl reboot'"
                        },
                        {
                            "label": "󰿅",
                            "command": "sh -c 'exit_apps && sleep 0.1 && hyprctl dispatch exit'"
                        },
                        {
                            "label": "󰉋",
                            "command": "hyprctl dispatch exec nemo"
                        },
                        {
                            "label": "",
                            "command": "hyprctl dispatch exec gimp"
                        },
                        {
                            "label": "󰖁",
                            "command": "pactl set-sink-mute @DEFAULT_SINK@ toggle"
                        },
                        {
                            "label": "󰍭",
                            "command": "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
                        },
                        {
                            "label": "󰓓",
                            "command": "hyprctl dispatch exec steam"
                        },
                        {
                            "label": "㽤",
                            "command": "hyprctl dispatch exec vivaldi"
                        },
                        {
                            "label": "",
                            "command": "hyprctl dispatch exec obs"
                        }
                    ]
                }
        }
    }
  '';

  home.file.".config/swaync/style.css".text = ''
    * {
        font-family: JetBrainsMono Nerd Font, Simple Icons, monospace;
    }

    .notification {
        background: transparent;
        padding: 0;
        margin: 0px;
        border-width: 2px;
        border-color: #78aeed;
    }

    .notification * {
        margin: 0;
        border-width: 2px;
        border-color: #78aeed;
    }

    .notification-content {
        background: transparent;
        margin: 5px;
    }

    .notification-action,
    .notification-default-action {
        background: #1e1e1e;
        margin: 0;
        padding: 2px;
    }

    .notification-action:hover,
    .notification-default-action:hover * {
        color: #78aeed;
    }

    .inline-reply {
        margin-top: 8px
    }

    .inline-reply-entry {
        background: #1e1e1e;
        color: #fafafa;
        caret-color: #fafafa;
        border: 1px solid #3584e4;
        border-radius: 5px
    }

    .inline-reply-button {
        margin-left: 4px;
        background: #1e1e1e;
        border: 1px solid #3584e4;
        border-radius: 5px;
        color: #fafafa
    }

    .inline-reply-button:disabled {
        background: initial;
        color: #404040;
        border: 1px solid transparent
    }

    .inline-reply-button:hover {
        background: #2a2a2a
    }

    .body-image {
        margin-top: 6px;
        background-color: #fafafa;
        border-radius: 5px
    }

    .summary {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: #fafafa;
        text-shadow: none
    }

    .time {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: #808080;
        text-shadow: none;
        margin-right: 26px
    }

    .body {
        font-size: 15px;
        font-weight: 400;
        background: transparent;
        color: #fafafa;
        text-shadow: none
    }

    .control-center {
        background: #1e1e1e;
        border: 2px solid #303030;
        border-radius: 12px;
    }

    .control-center-list {
        background: transparent
    }

    .control-center-list-placeholder {
        opacity: .5
    }

    .floating-notifications {
        background: transparent
    }

    .blank-window {
        background: alpha(black, 0)
    }

    .widget-title {
        color: #78aeed;
        background: #1e1e1e;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        font-size: 1.5rem;
        border-radius: 5px;
    }

    .widget-title>button {
        font-size: 1rem;
        color: #fafafa;
        text-shadow: none;
        background: #1e1e1e;
        box-shadow: none;
        border-radius: 5px;
    }

    .widget-title>button:hover {
        background: #ff7b63;
        color: #1e1e1e;
    }

    .widget-dnd {
        background: #1e1e1e;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: large;
        color: #78aeed;
    }

    .widget-dnd>switch {
        border-radius: 12px;
        /* border: 1px solid #78aeed; */
        background: #383838;
    }

    .widget-dnd>switch:checked {
        background: #3584e4;
        /* border: 1px solid #ff7b63; */
    }

    .widget-dnd>switch slider {
        background: #fafafa;
        border-radius: 10px
    }

    .widget-dnd>switch:checked slider {
        background: #fafafa;
        border-radius: 10px
    }

    .widget-label {
        margin: 10px 10px 5px 10px;
    }

    .widget-label>label {
        font-size: 1rem;
        color: #fafafa;
    }

    .widget-mpris {
        color: #fafafa;
        background: #1e1e1e;
        padding: 5px 10px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
    }

    .widget-mpris > box > button {
        border-radius: 5px;
    }

    .widget-mpris-player {
        padding: 5px 10px;
        margin: 10px
    }

    .widget-mpris-title {
        font-weight: 700;
        font-size: 1.25rem
    }

    .widget-mpris-subtitle {
        font-size: 1.1rem
    }

    .widget-buttons-grid {
        font-family: JetBrainsMono Nerd Font Propo, Simple Icons;
        font-size: xx-large;
        font-weight: normal;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        background: #242424;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button {
        font-weight: normal;
        margin: 3px;
        background: #383838;
        border-radius: 5px;
        color: #fafafa;
    }

    .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: #3584e4;
    }

    .widget-menubar>box>.menu-button-bar>button {
        border: none;
        background: transparent
    }

    .topbar-buttons>button {
        border: none;
        background: transparent
    }

    .widget-volume {
        background: #242424;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: #fafafa;
    }

    .widget-volume>box>button {
        background: #78aeed;
        border: none
    }

    .per-app-volume {
        background-color: #1e1e1e;
        padding: 4px 8px 8px;
        margin: 0 8px 8px;
        border-radius: 5px;
    }

    .widget-backlight {
        background: #242424;
        padding: 5px;
        margin: 10px 10px 5px 10px;
        border-radius: 5px;
        font-size: x-large;
        color: #fafafa
    }
  '';
}
