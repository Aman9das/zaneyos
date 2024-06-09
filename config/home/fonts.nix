{
  config,
  lib,
  pkgs,
  host,
  ...
}: {
  # Configure Fonts
  fonts.fontconfig.enable = true;

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "RecMonoDuotone Nerd Font"
      "RecMonoLinear Nerd Font"
      "Symbols Nerd Font Mono"
      "Simple Icons"
      "Noto Color Emoji"
      "Noto Emoji"
      "DejaVu Sans Mono"
    ];
    emoji = [
      "Noto Color Emoji"
      "Noto Emoji"
    ];
    sansSerif = [
      "Recursive Sans Linear"
      "Recursive Sans Linear Static"
      "Symbols Nerd Font Mono"
      "Simple Icons"
      "Noto Color Emoji"
      "Noto Emoji"
      "DejaVu Sans Mono"
    ];
    serif = [
      "Recursive Sans Casual"
      "Recursive Sans Casual Static"
      "Symbols Nerd Font Mono"
      "Simple Icons"
      "Noto Color Emoji"
      "Noto Emoji"
      "DejaVu Sans Mono"
    ];
  };
}
