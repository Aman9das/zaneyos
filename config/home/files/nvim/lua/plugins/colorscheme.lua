return {
  -- add base16 colorschemes
  -- {
  --   "RRethy/nvim-base16",
  --   -- priority = 500,
  -- },

  -- tairiki scheme
  -- {
  --   "deparr/tairiki.nvim",
  --   -- lazy = false,
  --   -- priority = 1000,
  -- },

  -- github themes
  -- {
  --   'projekt0n/github-nvim-theme',
  --   -- lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   -- priority = 1000, -- make sure to load this before all the other start plugins
  -- },

  {
    "HoNamDuong/hybrid.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      transparent = true,
    },
  },

  -- Configure LazyVim to load tomorrow-night
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "hybrid",
    },
  },

  -- fix nvim-notify colors
  {
    "rcarriga/nvim-notify",
    -- dependencies = {
    --   { "HoNamDuong/hybrid.nvim" },
    -- },
    opts = function(_, opts)
      local bg_color = require("hybrid.colors").palette.yellow
      opts.background_colour = bg_color
    end
  }
}
