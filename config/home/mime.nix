{ pkgs, config, lib, ... }:
{
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = ["vivaldi-stable.desktop"];
        "text/htm" = ["vivaldi-stable.desktop"];
        "x-scheme-handler/http" = ["vivaldi-stable.desktop"];
        "x-scheme-handler/https" = ["vivaldi-stable.desktop"];
        "x-scheme-handler/about" = ["vivaldi-stable.desktop"];
        "x-scheme-handler/unknown" = ["vivaldi-stable.desktop"];
        "x-scheme-handler/vivaldi" = [ "vivaldi-stable.desktop" ];
      };
    };
  };
}
