{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    quickemu
    spice-gtk
  ];

  xdg.desktopEntries.windows = {
    name = "Windows VM";
    genericName = "Windows VM";
    exec = "quickemu --vm system/vm/windows-11.conf --display spice";
    icon = "distributor-logo-windows";
    terminal = false;
  };
}
