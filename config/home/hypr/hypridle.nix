{
  pkgs,
  lib,
  config,
  ...
}: {
  # screen idle
  services.hypridle = {
      enable = true;

      settings = {
          beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
          lockCmd = "pidof hyprlock || hyprlock";

          listener = [
          {
              timeout = 150;
              onTimeout = "brightnessctl -s set 1";
              onResume = "brightnessctl -r";
            }
          {
              timeout = 300;
              onTimeout = "${pkgs.systemd}/bin/loginctl lock-session";
            }
          {
              timeout = 330;
              onTimeout = "hyprctl dispatch dpms off";
              onResume = "hyprctl dispatch dpms on";
            }
          {
              timeout = 600;
              onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
            }
          ];
        };
    };
}
