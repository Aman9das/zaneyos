{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
in {
  programs.nixvim = {
    enable = true;

    extraPlugins = [
      plugins.telescope-nvim
      plugins.rose-pine
      plugins.nvim-treesitter
      plugins.nvim-treesitter.withAllGrammars
    ];
    colorscheme = "rose-pine";

    globals.mapleader = " "; # Sets the leader key to space

    extraConfigLua = ''
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>s', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>tf";
        options.silent = false;
        action = "<cmd>Ex<CR>";
      }
    ];

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    };

  };
 } 
