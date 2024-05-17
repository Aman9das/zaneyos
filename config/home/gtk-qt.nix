{
  pkgs,
  lib,
  ...
}: let
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
    name = "Inter";
    package = pkgs.inter;
  };
  cursorTheme = {
    name = "Simp1e-Adw-Dark";
    size = 24;
    package = pkgs.simp1e-cursors;
  };
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme.override {color = "adwaita";};
  };
  kvlibadwaita = pkgs.callPackage ../pkgs/kvantum-libadwaita.nix {};
in {
  home = {
    packages = with pkgs; [
      cantarell-fonts
      font-awesome
      theme.package
      font.package
      cursorTheme.package
      iconTheme.package
      gnome.adwaita-icon-theme

      libsForQt5.breeze-qt5
      qt5ct
      qt6ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5.qtwayland
    ];
    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
      GTK_THEME = "adw-gtk3-dark";
    };
    pointerCursor =
      cursorTheme
      // {
        gtk.enable = true;
        x11.enable = true;
      };
    file = {
      ".local/share/themes/${theme.name}" = {
        source = "${theme.package}/share/themes/${theme.name}";
      };
      ".config/gtk-4.0/gtk.css".text = ''
        window.messagedialog .response-area > button,
        window.dialog.message .dialog-action-area > button,
        .background.csd{
          border-radius: 0;
        }
      '';
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    inherit font cursorTheme iconTheme;
    theme.name = theme.name;
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk3.extraCss = ''
      headerbar, .titlebar,
      .csd:not(.popup):not(tooltip):not(messagedialog) decoration{
        border-radius: 0;
      }
    '';
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style = {
      name = "kvantum";
    };
  };

  xdg = {
    configFile = {
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=${iconTheme.name}
        style=kvantum

        [Fonts]
        fixed="JetBrainsMono NF"
        general="Inter"
      '';

      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        icon_theme=${iconTheme.name}
        style=kvantum

        [Fonts]
        fixed="JetBrainsMono NF"
        general="Inter"
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
    };
  };
}
