{ pkgs, config, wallpaperDir,
  wallpaperGit, username, ... }:

{
  system.activationScripts = {
    gitwallpapers.text = ''
      if [ -d ${wallpaperDir} ]; then
        cd ${wallpaperDir}
        ${pkgs.git}/bin/git pull
      else
        ${pkgs.git}/bin/git clone ${wallpaperGit} ${wallpaperDir}
        chown -R ${username}:users ${wallpaperDir}
      fi
    '';
  };
}
