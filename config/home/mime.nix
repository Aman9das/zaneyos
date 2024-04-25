{ pkgs, config, lib, ... }:
{
  xdg = {
      enable = true;

      mimeApps = {
          enable = true;

          defaultApplications = {
            "x-scheme-handler/vivaldi" = [ "vivaldi-stable.desktop" ];
            };
        };
    };
}
