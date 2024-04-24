return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- r formatter
        -- ["r"] = { "rprettify" },
        ["python"] = { "black" },
        ["quarto"] = { "markdownlint-cli2" },
        ["rmd"] = { "markdownlint-cli2" },
        ["markdown"] = { "markdownlint-cli2" },
        ["css"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        ["*"] = { "typos", "trim_whitespace", "trim_newlines" },
      },
      formatters = {
        rprettify = {
          inherit = false,
          stdin = false,
          command = "rprettify",
          args = { "$FILENAME" },
        },
        injected = {
          -- Set the options field
          options = {
            -- Set to true to ignore errors
            ignore_errors = false,
            -- Map of treesitter language to file extension
            -- A temporary file name with this extension will be generated during formatting
            -- because some formatters care about the filename.
            lang_to_ext = {
              bash = "sh",
              c_sharp = "cs",
              elixir = "exs",
              javascript = "js",
              julia = "jl",
              latex = "tex",
              markdown = "md",
              python = "py",
              ruby = "rb",
              rust = "rs",
              teal = "tl",
              r = "r",
              typescript = "ts",
            },
            -- Map of treesitter language to formatters to use
            -- (defaults to the value from formatters_by_ft)
            lang_to_formatters = {
              ["r"] = { "rprettify" },
            },
          },
        },
      },
      log_level = vim.log.levels.DEBUG,
    },
  },
}
