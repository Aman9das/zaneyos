-- This is a config that can be merged with your
-- existing LazyVim config.
--
-- It configures all plugins necessary for quarto-nvim,
-- such as adding its code completion source to the
-- completion engine nvim-cmp.
-- Thus, instead of having to change your configuration entirely,
-- this takes your existings config and adds on top where necessary.

return {

  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {
      lspFeatures = {
        languages = {
          "r",
          "python",
          "julia",
          "bash",
          "lua",
          "html",
          "dot",
          "javascript",
          "typescript",
          "ojs",
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
      keymap = {
        rename = "<leader>qR",
        format = "<leader>qf",
      },
    },
    dependencies = {
      "jmbuhr/otter.nvim",
    },
  },

  {
    "jmbuhr/otter.nvim",
    lazy = true,
    keys = {
      {
        "<leader>cF",
        require("otter").ask_format,
        mode = { "n" },
        desc = "code chunk format",
      },
    },
    dependencies = {
      "hrsh7th/nvim-cmp", -- optional, for completion
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        set_filetype = true,
      },
      handle_leading_whitespace = true,
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "jmbuhr/otter.nvim" },
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "otter" } }))
  --   end,
  -- },

  -- paste an image from the clipboard or drag-and-drop
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    opts = {
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },

  -- paste an image from the clipboard or drag-and-drop
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    opts = {
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },

  -- preview equations
  {
    "jbyuki/nabla.nvim",
    keys = {
      {
        "<leader>oe",
        ':lua require"nabla".toggle_virt()<cr>',
        desc = "toggle math equations",
      },
    },
  },

  {
    "benlubas/molten-nvim",
    enabled = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "molten eval visual",
      },
      {
        "<leader>mr",
        ":MoltenReevaluateCell<cr>",
        desc = "molten re-eval cell",
      },
    },
  },
}
