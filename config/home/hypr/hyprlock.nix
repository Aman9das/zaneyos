{
  pkgs,
  lib,
  config,
  ...
}: {
  # screen idle
  home.packages = with pkgs; [
    hyprlock
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = $HOME/pictures/Wallpapers/nix-wallpaper-nineish-dark-gray.png   # only png supported for now

        blur_size = 2
        blur_passes = 1
        noise = 0
    }

    input-field {
        size = 1620, 240
        outline_thickness = 0
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
        outer_color = rgb(151515)
        inner_color = rgba(FFFFFF00)
        font_color = rgb(fafafa)
        fade_on_empty = true
        fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
        placeholder_text = # Text rendered in the input box when it's empty.
        hide_input = false
        rounding = -1 # -1 means complete rounding (circle/oval)
        check_color = rgb(f8e45c)
        fail_color = rgb(ff7b63) # if authentication failed, changes outer_color and fail message color
        fail_text = # can be set to empty
        fail_transition = 300 # transition time in ms between normal outer_color and fail_color
        position = 0, 0
        halign = center
        valign = center
    }
  '';
}
