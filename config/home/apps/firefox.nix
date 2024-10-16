{ inputs, pkgs, ... }:
{
  home = {
    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = pkgs.fetchFromGitHub {
        "owner" = "rafaelmardojai";
        "repo" = "firefox-gnome-theme";
        "rev" = "fb5b578a4f49ae8705e5fea0419242ed1b8dba70";
        "hash" = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM=";
      };
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "browser.tabs.loadInBackground" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
  };
}
