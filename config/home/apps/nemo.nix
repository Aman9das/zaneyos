{
  config,
  lib,
  pkgs,
  ...
}:
let
  # create a fake gnome-terminal shell script so xdg terminal applications open in the correct terminal
  # https://unix.stackexchange.com/a/642886
  fakeGnomeTerminal = pkgs.writeShellApplication {
    name = "gnome-terminal";
    text = ''kitty "$@"'';
  };
  nemo-patched = pkgs.cinnamon.nemo-with-extensions.overrideAttrs (_: {
    postFixup = ''
      wrapProgram $out/bin/nemo \
        --prefix PATH : "${lib.makeBinPath [ fakeGnomeTerminal ]}"
    '';
  });
in
{
  home = {
    packages = [
      # pkgs.cinnamon.nemo-fileroller
      nemo-patched
    ];
  };

  xdg = {
    # fix mimetype associations
    mimeApps.defaultApplications =
      {
        "inode/directory" = "nemo.desktop";
        # wtf zathura registers itself to open archives
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/vnd.rar" = "org.gnome.FileRoller.desktop";
        "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      };
      # // lib.optionalAttrs config.programs.zathura.enable {
      #   "application/pdf" = "org.pwmt.zathura.desktop";
      # }
      # // (lib.optionalAttrs config.programs.pqiv.enable {
      #   "image/jpeg" = "pqiv.desktop";
      #   "image/gif" = "pqiv.desktop";
      #   "image/webp" = "pqiv.desktop";
      #   "image/png" = "pqiv.desktop";
      # });

    # other OSes seem to override this file
    # configFile = {
    #   "mimeapps.list".force = true;
    #   "gtk-3.0/bookmarks".force = true;
    # };
  };

  gtk.gtk3.bookmarks =
    let
      homeDir = config.home.homeDirectory;
    in
    [
      "file://${homeDir}/downloads"
      "file://${homeDir}/projects"
      "file://${homeDir}/pictures"
    ];

  dconf.settings = {
    # fix open in terminal
    "org/gnome/desktop/applications/terminal" = {
      exec = "kitty";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty";
    };
    "org/nemo/preferences" = {
      # default-folder-viewer = "list-view";
      # show-hidden-files = true;
      # start-with-dual-pane = true;
      date-format-monospace = true;
      # needs to be a uint64!
      thumbnail-limit = lib.hm.gvariant.mkUint64 (100 * 1024 * 1024); # 100 mb
    };
    "org/nemo/window-state" = {
      sidebar-bookmark-breakpoint = 480;
      sidebar-width = 180;
    };
    "org/nemo/preferences/menu-config" = {
      selection-menu-make-link = true;
      selection-menu-copy-to = true;
      selection-menu-move-to = true;
    };
  };

}
