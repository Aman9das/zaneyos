{
  pkgs,
  config,
  lib,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/options.nix) flatpak;
in
lib.mkIf (flatpak == true) {
  services.flatpak.enable = true;

  services.flatpak.remotes = lib.mkOptionDefault [ ];

  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.packages = [
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
    "com.github.tchx84.Flatseal"
    "io.ente.auth"
    "org.fontforge.FontForge"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
    # "com.remnantsoftheprecursors.ROTP"
  ];
}
