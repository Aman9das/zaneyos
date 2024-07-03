{
  pkgs,
  config,
  lib,
  host,
  ...
}:
{
  services = {
    syncthing = {
      enable = true;
    };
  };
}
