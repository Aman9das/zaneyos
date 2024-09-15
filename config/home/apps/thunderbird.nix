{
  inputs,
  pkgs,
  pkgs-unstable,
  config,
  ...
}:
{
  config = {
    programs.thunderbird = {
      enable = true;
      package = pkgs.thunderbird;
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
