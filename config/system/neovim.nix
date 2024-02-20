{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
  inherit (import ../../options.nix) theme;
in {
  programs.nixvim = {
    enable = true;

    plugins = {
      telescope.enable = true;
      neo-tree.enable = true;
      indent-blankline.enable = true;
      lualine = {
	enable = true;
	theme = "auto";
      };
      startup = { 
	enable = true;
	theme = "dashboard";
	userMappings = {
	  "<leader>ff" = "<cmd>Telescope find_files<CR>";
	  "<leader>s"  = "<cmd>Telescope live_grep<CR>";
	  "<leader>fb"  = "<cmd>Neotree reveal right<CR>";
	};
      };
      comment-nvim.enable = true;
      lsp = {
	enable = true;
	servers = {
	  tsserver.enable = true;
	  lua-ls.enable = true;
	  bashls.enable = true;
	  rust-analyzer = {
	    enable = true;
	    installRustc = true;
	    installCargo = true;
	  };
	  nixd.enable = true;
	  html.enable = true;
	  ccls.enable = true;
	  cmake.enable = true;
	  csharp-ls.enable = true;
	  cssls.enable = true;
	  gopls.enable = true;
	  jsonls.enable = true;
	  pyright.enable = true;
	  tailwindcss.enable = true;
	};
      };
      treesitter.enable = true;
      nvim-cmp = {
	enable = true;
	autoEnableSources = true;
	sources = [
	  { name = "nvim_lsp"; }
	  { name = "path"; }
	  { name = "buffer"; }
	];
	mapping = {
	  "<CR>" = "cmp.mapping.confirm({ select = true })";
	  "<Tab>" = {
	    action = ''cmp.mapping.select_next_item()'';
	    modes = [ "i" "s" ];
	  };
	};
      };
    };

    extraPlugins = [
      plugins.vim-airline-themes
      plugins.nvim-base16
    ];

    globals.mapleader = " "; # Sets the leader key to space

    extraConfigLua = ''
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>s', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.api.nvim_set_option("clipboard","unnamed")
    '';

    extraConfigVim = ''
      set noshowmode
      colorscheme base16-${theme}
      inoremap jj <ESC>
      let s:guifontsize = 16
      let s:guifont = "JetBrainsMono\\ Nerd\\ Font"
      " " Copy to clipboard
      vnoremap  <leader>y  "+y
      nnoremap  <leader>Y  "+yg_
      nnoremap  <leader>y  "+y
      nnoremap  <leader>yy  "+yy

      " " Paste from clipboard
      nnoremap <leader>p "+p
      nnoremap <leader>P "+P
      vnoremap <leader>p "+p
      vnoremap <leader>P "+P
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>tf";
        options.silent = false;
        action = "<cmd>Ex<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        options.silent = false;
        action = "<cmd>Neotree reveal right<CR>";
      }
    ];

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      softtabstop = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };

  };
 } 
