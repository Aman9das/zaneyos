{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs; [
    icu
    gcc

    neovide
  ];

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
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
      markdownlint-cli2
      sqlfluff

      codeium
      marksman
      icu
      prettierd

      black
      (pkgs.python3.withPackages (python-pkgs: [ python-pkgs.pip ]))

      #nix
      nil
      nixfmt-rfc-style

      #images
      imagemagick
    ];

    extraLuaPackages = ps: [
      ps.magick
      ps.luarocks
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
