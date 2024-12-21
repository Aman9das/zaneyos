{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [ fusuma ];
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [
      hyprland
      hyprnome
      coreutils
    ];
    settings = {
      threshold = {
        swipe = 0.25;
        hold = 0.5;
      };
      interval = {
        swipe = 1;
        hold = 0.5;
      };
      swipe = {
        "3" = {
          left = {
            command = "hyprctl dispatch movefocus l";
          };
          right = {
            command = "hyprctl dispatch movefocus r";
          };
          down = {
            command = "hyprctl dispatch exec \"hyprnome --previous\"";
          };
          up = {
            command = "hyprctl dispatch exec hyprnome";
          };
        };
        "4" = {
          left = {
            sendkey = "LEFTALT+LEFT"; # history back
          };
          right = {
            sendkey = "LEFTALT+RIGHT"; # history forward
          };
          # up = {
          #   command = "hyprctl dispatch scroller:toggleoverview";
          # };
        };
      };
    };
  };
}
