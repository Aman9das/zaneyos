{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    fusuma
  ];
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [hyprland hyprnome coreutils];
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
            command = "hyprctl dispatch scroller:movefocus l";
          };
          right = {
            command = "hyprctl dispatch scroller:movefocus r";
          };
          down = {
            command = "hyprnome --previous";
          };
          up = {
            command = "hyprnome";
          };
        };
        "4" = {
          left = {
            sendkey = "LEFTALT+LEFT"; # history back
          };
          right = {
            sendkey = "LEFTALT+RIGHT"; # history forward
          };
          down = {
            sendkey = "LEFTCTRL+TAB"; # change tab
          };
        };
      };
      hold = {
        "4" = {
          # command = "hyprctl dispatch hyprexpo:expo toggle";
        };
      };
    };
  };
}
