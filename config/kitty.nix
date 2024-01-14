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
      foreground ${base15}
      background ${base00}
      color0  ${base00}
      color8  ${base00}
      color1  ${base01}
      color9  ${base09}
      color2  ${base02}
      color10 ${base0A}
      color3  ${base03}
      color11 ${base0B}
      color4  ${base04}
      color12 ${base0C}
      color5  ${base05}
      color13 ${base0D}
      color6  ${base06}
      color14 ${base0E}
      color7  ${base07}
      color15 ${base0F}
      cursor  ${base07}
      cursor_text_color ${base00}
      selection_foreground none
      selection_background ${base08}
      url_color ${base02}
      active_border_color ${base04}
      inactive_border_color ${base00}
      bell_border_color ${base03}
      tab_bar_style fade
      tab_fade 1
      active_tab_foreground   ${base04}
      active_tab_background   ${base00}
      active_tab_font_style   bold
      inactive_tab_foreground ${base07}
      inactive_tab_background ${base08}
      inactive_tab_font_style bold
      tab_bar_background ${base00}
    '';
  };
}
