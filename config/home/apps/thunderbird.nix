{
  inputs,
  pkgs,
  config,
  ...
}:
{
  config = {
    home.file."thunderbird-gnome-theme" = {
      target = ".thunderbird/default/chrome/thunderbird-gnome-theme";
      source = pkgs.fetchFromGitHub {
        "owner" = "rafaelmardojai";
        "repo" = "thunderbird-gnome-theme";
        "rev" = "65d5c03fc9172d549a3ea72fd366d544981a002b";
        "hash" = "sha256-nQBz2PW3YF3+RTflPzDoAcs6vH1PTozESIYUGAwvSdA=";
      };
    };

    programs.thunderbird = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable customChrome.cs
            "svg.context-properties.content.enabled" = true; # Enable SVG context-properties
          };
        };
      };
    };
  };
}
