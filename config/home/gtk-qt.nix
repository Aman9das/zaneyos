{ pkgs, config, gtkThemeFromScheme, ... }:

{

  # Theme GTK
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 12;
      package = pkgs.ubuntu_font_family;
    };
    theme = {
      name = "${config.colorScheme.slug}";
      package = gtkThemeFromScheme {scheme = config.colorScheme;};
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
    };
  };
}
