{ pkgs, config, ... }:
{
  # Place Files Inside Home Directory
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };

  home.file.".config" = {
    source = ./files/configs;
    recursive = true;
  };

  home.file.".ipython/profile_default/ipython_config.py" = {
    source = ./files/ipython_config.py;
  };
  home.file.".prettierrc" = {
    source = ./files/.prettierrc;
  };
  home.file.".markdownlint-cli2.yaml" = {
    source = ./files/.markdownlint-cli2.yaml;
  };
}
