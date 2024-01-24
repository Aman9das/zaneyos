{ pkgs, config, ... }:

{
  # Configure Kitty
  programs.kitty = {
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
      foreground #${config.colorScheme.colors.base05}
      background #${config.colorScheme.colors.base00}
      color0  #${config.colorScheme.colors.base03}
      color1  #${config.colorScheme.colors.base08}
      color2  #${config.colorScheme.colors.base0B}
      color3  #${config.colorScheme.colors.base09}
      color4  #${config.colorScheme.colors.base0D}
      color5  #${config.colorScheme.colors.base0E}
      color6  #${config.colorScheme.colors.base0C}
      color7  #${config.colorScheme.colors.base06}
      color8  #${config.colorScheme.colors.base04}
      color9  #${config.colorScheme.colors.base08}
      color10 #${config.colorScheme.colors.base0B}
      color11 #${config.colorScheme.colors.base0A}
      color12 #${config.colorScheme.colors.base0C}
      color13 #${config.colorScheme.colors.base0E}
      color14 #${config.colorScheme.colors.base0C}
      color15 #${config.colorScheme.colors.base07}
      color16 #${config.colorScheme.colors.base00}
      color17 #${config.colorScheme.colors.base0F}
      color18 #${config.colorScheme.colors.base0B}
      color19 #${config.colorScheme.colors.base09}
      color20 #${config.colorScheme.colors.base0D}
      color21 #${config.colorScheme.colors.base0E}
      color22 #${config.colorScheme.colors.base0C}
      color23 #${config.colorScheme.colors.base06}
      cursor  #${config.colorScheme.colors.base07}
      cursor_text_color #${config.colorScheme.colors.base00}
      selection_foreground #${config.colorScheme.colors.base01}
      selection_background #${config.colorScheme.colors.base0D}
      url_color #${config.colorScheme.colors.base0C}
      active_border_color #${config.colorScheme.colors.base04}
      inactive_border_color #${config.colorScheme.colors.base00}
      bell_border_color #${config.colorScheme.colors.base03}
      tab_bar_style fade
      tab_fade 1
      active_tab_foreground   #${config.colorScheme.colors.base04}
      active_tab_background   #${config.colorScheme.colors.base00}
      active_tab_font_style   bold
      inactive_tab_foreground #${config.colorScheme.colors.base07}
      inactive_tab_background #${config.colorScheme.colors.base08}
      inactive_tab_font_style bold
      tab_bar_background #${config.colorScheme.colors.base00}
    '';
  };
}
