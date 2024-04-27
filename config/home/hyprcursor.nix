{ pkgs, config, lib, ... }:
let
    cursor_package = pkgs.bibata-cursors;
    cursor_name = "Bibata-Modern-Ice";
    cursor_size = 24;
in
{
  home = {
      sessionVariables = {
        XCURSOR_THEME = cursor_name;
        XCURSOR_SIZE = cursor_size;
        HYPRCURSOR_THEME = cursor_name;
        HYPRCURSOR_SIZE = builtins.toString cursor_size;
      };
      pointerCursor = {
        package = cursor_package;
        name = cursor_name;
        size = cursor_size;
        gtk.enable = true;
        x11.enable = true;
      };
    };
}

