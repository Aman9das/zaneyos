{ pkgs, config, ... }:

{
  home.file.".config/swaylock/config".text = ''
    indicator
    ignore-empty-password
    indicator-thickness=15
    indicator-radius=150
    image=~/Pictures/Wallpapers/Gangsta-Hoodie.jpeg
    clock
    effect-blur=7x5
    effect-vignette=0.5:0.5
    ring-color=${config.colorScheme.colors.base0D}
    key-hl-color=${config.colorScheme.colors.base0F}
    line-color=00000000
    inside-color=00000088
    inside-clear-color=00000088
    text-color=${config.colorScheme.colors.base05}
    text-clear-color=${config.colorScheme.colors.base05}
    ring-clear-color=${config.colorScheme.colors.base0D}
    separator-color=00000000
    grace=2
    fade-in=0.5
    font=Ubuntu
  '';
}
