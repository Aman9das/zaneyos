{
  pkgs,
  config,
  lib,
  host,
  ...
}: let
  # palette = config.colorScheme.palette;
  inherit (import ../../hosts/${host}/options.nix) alacritty wezterm kitty;
in
  lib.mkIf (wezterm
    == false
    && alacritty == false
    || kitty == true) {
    # Configure Kitty
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 10;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
        background_opacity = "0.85";
        term = "kitty";
      };
      extraConfig = ''
        background            #161718
        foreground            #b7bcb9
        cursor                #b7bcb9
        selection_background  #b5b8b6
        color0                #2a2e33
        color8                #404040
        color1                #b74d50
        color9                #8c2d32
        color2                #b3be5a
        color10               #788331
        color3                #e3b55e
        color11               #e5894f
        color4                #6d90b0
        color12               #4b6b88
        color5                #a07eab
        color13               #6e4f79
        color6                #7fbeb3
        color14               #4d7b73
        color7                #b5b8b6
        color15               #5a6169
        selection_foreground  #161718
        inactive_tab_font_style bold
        active_tab_font_style   bold
        tab_bar_style separator
        tab_separator ""
        tab_title_template " {index}: {title} "

        # Jump around neighboring window Vi key binding
        map ctrl+shift+w>h neighboring_window left
        map ctrl+shift+w>l neighboring_window right
        map ctrl+shift+w>j neighboring_window down
        map ctrl+shift+w>k neighboring_window up

        map ctrl+shift+w>shift+h move_window left
        map ctrl+shift+w>shift+l move_window right
        map ctrl+shift+w>shift+j move_window down
        map ctrl+shift+w>shift+k move_window up

        # Create a new window splitting the space used by the existing one so that
        # the two windows are placed one above the other
        map ctrl+shift+w>s launch --location=hsplit

        # Create a new window splitting the space used by the existing one so that
        # the two windows are placed side by side
        map ctrl+shift+w>v launch --location=vsplit
      '';
    };
    home.sessionVariables = {
      TERMINAL = "kitty";
      TERM = "kitty";
    };
  }
