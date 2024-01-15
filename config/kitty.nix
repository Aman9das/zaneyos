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
      color0  #${config.colorScheme.colors.base00}
      color8  #${config.colorScheme.colors.base01}
      color1  #${config.colorScheme.colors.base02}
      color9  #${config.colorScheme.colors.base03}
      color2  #${config.colorScheme.colors.base04}
      color10 #${config.colorScheme.colors.base05}
      color3  #${config.colorScheme.colors.base06}
      color11 #${config.colorScheme.colors.base07}
      color4  #${config.colorScheme.colors.base08}
      color12 #${config.colorScheme.colors.base09}
      color5  #${config.colorScheme.colors.base0A}
      color13 #${config.colorScheme.colors.base0B}
      color6  #${config.colorScheme.colors.base0C}
      color14 #${config.colorScheme.colors.base0D}
      color7  #${config.colorScheme.colors.base0E}
      color15 #${config.colorScheme.colors.base0F}
      cursor  #${config.colorScheme.colors.base07}
      cursor_text_color #${config.colorScheme.colors.base00}
      selection_foreground none
      selection_background #${config.colorScheme.colors.base08}
      url_color #${config.colorScheme.colors.base02}
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
