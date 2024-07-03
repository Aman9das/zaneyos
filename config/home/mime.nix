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
        "text/plain" = ["nvim.desktop"];
        "text/css" = ["nvim.desktop"];
        "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
        "text/htm" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/about" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/unknown" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/vivaldi" = ["vivaldi-stable.desktop"];
        "inode/directory" = ["nemo.desktop"];
        "x-scheme-handler/mailto" = ["thunderbird.desktop"];
        "message/rfc822" = ["thunderbird.desktop"];
        "x-scheme-handler/mid" = ["thunderbird.desktop"];
        "x-scheme-handler/news" = ["thunderbird.desktop"];
        "x-scheme-handler/snews" = ["thunderbird.desktop"];
        "x-scheme-handler/nntp" = ["thunderbird.desktop"];
        "x-scheme-handler/feed" = ["thunderbird.desktop"];
        "application/rss+xml" = ["thunderbird.desktop"];
        "application/x-extension-rss" = ["thunderbird.desktop"];
        "x-scheme-handler/webcal" = ["thunderbird.desktop"];
        "x-scheme-handler/webcals" = ["thunderbird.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop" "imv-dir.desktop" "imv.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop" "imv-dir.desktop" "imv.desktop"];
        "image/svg" = ["org.gnome.Loupe.desktop" "imv-dir.desktop" "imv.desktop"];
        "text/markdown" = ["nvim.desktop"];
        "application/pdf" = ["com.github.ahrm.sioyek.desktop" "zathura.desktop"];
        "x-scheme-handler/magnet" = ["transmission-gtk.desktop"];
      };
    };
  };

  home.sessionVariables = {
    BROWSER = "qutebrowser";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
