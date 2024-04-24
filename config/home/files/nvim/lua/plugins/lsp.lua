return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "yaml-language-server",
        "json-lsp",
        "r-languageserver",
        "texlab",
        "pyright",
        -- "mdformat",
        "markdownlint-cli2",
        "typos",
        "prettierd",
        "black",
        -- "cbfmt",
        -- "codespell"
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          filetypes = { "markdown", "quarto", "rmd" },
          root_dir = require("lspconfig.util").root_pattern(
            ".git",
            ".marksman.toml",
            "_quarto.yml"
          ),
        },

        r_language_server = {},

        pyright = {},

        julials = {},

        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },

        cssls = {},

        html = {},

        emmet_language_server = {},

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
                url = "",
              },
            },
          },
        },

        dotls = {},

        tsserver = {
          filetypes = { "js", "javascript", "typescript", "ojs" },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "r",
        "python",
        "markdown",
        "markdown_inline",
        "julia",
        "bash",
        "yaml",
        "lua",
        "vim",
        "query",
        "vimdoc",
        "latex",
        "html",
        "css",
        "dot",
        "javascript",
        "mermaid",
        "norg",
        "typescript",
        "c",
        "json",
        "luadoc",
        "luap",
        "regex",
        "tsx",
      },
    },
  },
}
