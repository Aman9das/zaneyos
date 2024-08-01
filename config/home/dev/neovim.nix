{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nil
    alejandra
    marksman
    icu
    gcc
    zathura
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua

      # Telescope
      ripgrep
      fd

      # Clipboard
      wl-clipboard-x11

      # Treesitter
      tree-sitter
      gcc

      # other language servers
      rPackages.languageserver
      rPackages.languageserversetup

      codeium
      marksman
      icu

      black
      (pkgs.python3.withPackages (python-pkgs: [ python-pkgs.pip ]))

      #nix
      nil
      nixfmt-rfc-style
    ];
  };

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  home.activation.setup-nvim = lib.hm.dag.entryAfter [ "installPackages" ] ''
    PATH="${config.home.path}/bin:$PATH"
        if ! [ -d "${config.xdg.configHome}/nvim" ]; then
         git clone --depth=1 --single-branch "https://github.com/Aman9das/lazy-nvim-dotfiles.git" "${config.xdg.configHome}/nvim"
       fi
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
