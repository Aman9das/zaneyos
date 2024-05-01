{ config, lib, pkgs, ... }:

{
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

      # other language servers
      rPackages.languageserver
      rPackages.languageserversetup

      black
      nil
    ];

  #   plugins = with pkgs.vimPlugins; [
  #     lazy-nvim
  #   ];
  #
  #   extraLuaConfig =
  #     let
  #       plugins = with pkgs.vimPlugins; [
  #         # LazyVim
  #         LazyVim
  #         bufferline-nvim
  #         cmp-buffer
  #         cmp-nvim-lsp
  #         cmp-path
  #         cmp_luasnip
  #         conform-nvim
  #         dashboard-nvim
  #         dressing-nvim
  #         flash-nvim
  #         friendly-snippets
  #         gitsigns-nvim
  #         indent-blankline-nvim
  #         lualine-nvim
  #         neo-tree-nvim
  #         neoconf-nvim
  #         neodev-nvim
  #         noice-nvim
  #         nui-nvim
  #         nvim-cmp
  #         nvim-lint
  #         nvim-lspconfig
  #         nvim-notify
  #         nvim-spectre
  #         nvim-treesitter
  #         nvim-treesitter-context
  #         nvim-treesitter-textobjects
  #         nvim-ts-autotag
  #         nvim-ts-context-commentstring
  #         nvim-web-devicons
  #         persistence-nvim
  #         plenary-nvim
  #         telescope-fzf-native-nvim
  #         telescope-nvim
  #         todo-comments-nvim
  #         tokyonight-nvim
  #         trouble-nvim
  #         vim-illuminate
  #         vim-startuptime
  #         which-key-nvim
  #         codeium-nvim
  #         quarto-nvim
  #         { name = "LuaSnip"; path = luasnip; }
  #         { name = "catppuccin"; path = catppuccin-nvim; }
  #         { name = "mini.ai"; path = mini-nvim; }
  #         { name = "mini.bufremove"; path = mini-nvim; }
  #         { name = "mini.comment"; path = mini-nvim; }
  #         { name = "mini.indentscope"; path = mini-nvim; }
  #         { name = "mini.pairs"; path = mini-nvim; }
  #         { name = "mini.surround"; path = mini-nvim; }
  #       ];
  #       mkEntryFromDrv = drv:
  #         if lib.isDerivation drv then
  #           { name = "${lib.getName drv}"; path = drv; }
  #         else
  #           drv;
  #       lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
  #     in
  #     ''
  #       require("lazy").setup({
  #         defaults = {
  #           lazy = true,
  #         },
  #         dev = {
  #           -- reuse files from pkgs.vimPlugins.*
  #           path = "${lazyPath}",
  #           patterns = { "." },
  #           -- fallback to download
  #           fallback = true,
  #         },
  #         spec = {
  #           { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  #           -- The following configs are needed for fixing lazyvim on nix
  #           -- force enable telescope-fzf-native.nvim
  #           { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
  #           -- disable mason.nvim, use programs.neovim.extraPackages
  #           { "williamboman/mason-lspconfig.nvim", enabled = false },
  #           { "williamboman/mason.nvim", enabled = false },
  #           -- import/override with your plugins
  #           { import = "plugins" },
  #           -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
  #           { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
  #         },
  #       })
  #     '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  # xdg.configFile."nvim/parser".source =
  #   let
  #     parsers = pkgs.symlinkJoin {
  #       name = "treesitter-parsers";
  #       paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
  #         c
  #         lua
  #       ])).dependencies;
  #     };
  #   in
  #   "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
     owner = "Aman9das";
     repo = "lazy-nvim-dotfiles";
     rev = "6bd42e4e9ca4caa72c09be41e4e86af81750c969";
     sha256 = "tBsFr0FB4h6+WYdl/x7N/tkzUDNDKuvvw2IxVXVvS14=";
  };
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
