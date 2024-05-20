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
        swipe = 0.1;
      };
      interval = {
        swipe = 0.7;
      };
      swipe = {
        "3" = {
          left = {
            command = "hyprctl dispatch scroller:movefocus r";
          };
          right = {
            command = "hyprctl dispatch scroller:movefocus l";
          };
        };
      };
    };
  };
}
