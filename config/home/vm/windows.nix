{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ quickemu ];

  # home.activation.setup-windowsvm = lib.hm.dag.entryAfter ["installPackages"] ''
  #   PATH="${config.home.path}/bin:$PATH"
  #       if ! [ -d "${config.xdg.configHome}/nvim" ]; then
  #        git clone --depth=1 --single-branch "https://github.com/Aman9das/lazy-nvim-dotfiles.git" "${config.xdg.configHome}/nvim"
  #      fi
  # '';
}
