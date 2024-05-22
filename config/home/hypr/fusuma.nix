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
    extraPackages = with pkgs; [hyprland coreutils];
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
            command = "hyprctl dispatch scroller:movefocus r";
          };
          right = {
            command = "hyprctl dispatch scroller:movefocus l";
          };
          down = {
            command = "hyprctl dispatch workspace r-1";
          };
          up = {
            command = "hyprctl dispatch workspace r+1";
          };
        };
        "4" = {
          up = {
            # command = "hyprctl dispatch hyprexpo:expo on";
            threshold = 1;
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
