{
  pkgs,
  config,
  host,
  ...
}:
let
  inherit (import ../../../hosts/${host}/options.nix) screenshotDir;
in
{
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=${screenshotDir}
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Inter
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';
}
