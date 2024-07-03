{ inputs, pkgs, ... }:
{
  home = {
    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = pkgs.fetchFromGitHub {
        "owner" = "rafaelmardojai";
        "repo" = "thunderbird-gnome-theme";
        "rev" = "c4eec329c464f3f89ab78a56a47eee6271ea9d19";
        "hash" = "sha256-EACja6V2lNh67Xvmhr0eEM/VeqM7OlTTm/81LhRbsBE=";
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
