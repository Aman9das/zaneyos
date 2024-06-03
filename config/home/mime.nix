{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
        "text/htm" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/about" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/unknown" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/vivaldi" = ["vivaldi-stable.desktop"];
        "inode/directory" = ["nemo.desktop"];
      };
    };
  };
  home.sessionVariables = {
    BROWSER = "qutebrowser";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
