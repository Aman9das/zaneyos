{ pkgs, lib, ... }:
let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ];
  };

  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  font = {
    name = "Recursive Sans Linear Static";
    package = pkgs.recursive;
  };
  cursorTheme = {
    name = "Simp1e-Adw-Dark";
    size = 24;
    package = pkgs.simp1e-cursors;
  };
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme.override { color = "adwaita"; };
  };
  kvlibadwaita = pkgs.callPackage ../pkgs/kvantum-libadwaita.nix { };
in
{
  home = {
    packages = with pkgs; [
      theme.package
      font.package
      cursorTheme.package
      iconTheme.package

      libsForQt5.breeze-qt5
      libsForQt5.qt5ct
      qt6ct
      libsForQt5.qt5.qtwayland
      kdePackages.qtwayland

    ];
    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
      GTK_THEME = "adw-gtk3-dark";
    };
    pointerCursor = cursorTheme // {
      gtk.enable = true;
      x11.enable = true;
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    inherit cursorTheme iconTheme theme;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    # gtk4.extraConfig = {
    #   gtk-application-prefer-dark-theme = 1;
    # };
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style = {
      name = "qt5ct-style";
    };
  };

  xdg = {
    configFile = {
      kdeglobals.source = "${pkgs.libsForQt5.breeze-qt5}/share/color-schemes/BreezeDark.colors";

      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=${iconTheme.name}
        style=Breeze
        standard_dialogs=Default

        [Fonts]
        fixed="RecMonoLinear Nerd Font"
        general="Recursive Sans Linear Static,10"
      '';

      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        icon_theme=${iconTheme.name}
        style=Breeze
        standard_dialogs=Default

        [Fonts]
        fixed="RecMonoLinear Nerd Font"
        general="Recursive Sans Linear Static,10"
      '';

      "Kvantum/kvantum.kvconfig".text = ''
        theme=KvLibadwaitaDark
      '';

      "Kvantum/KvLibadwaita".source = "${kvlibadwaita}/share/Kvantum/KvLibadwaita";
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/freedesktop/appearance" = {
        color-scheme = 1;
      };
    };
  };
}
