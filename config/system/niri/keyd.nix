{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.global = {
        overload_tap_timeout = 200; # Milliseconds to register a tap before timeout
      };
      settings.main = {
        compose = "layer(meta)"; # Make the menu key press super
        leftmeta = "overload(meta, macro(leftmeta+d))"; # Make left meta tap open rofi keybind
      };
    };
  };
}
