return {
  -- oatmeal ollama client
  {
    "dustinblackman/oatmeal.nvim",
    enabled = true,
    cmd = { "Oatmeal" },
    keys = {
      { "<leader>o", desc = "other" },
      { "<leader>om", mode = "n", desc = "Oatmeal session" },
      { "<leader>om", mode = "v", desc = "Oatmeal session on chunk" },
    },
    opts = {
      -- Set to empty string to disable.
      hotkey = "<leader>om",
      close_terminal_on_quit = true,

      -- CLI
      backend = "openai",
      model = "llama2-70b-4096",
      theme_file = "~/.config/oatmeal/base16-tomorrow-night.tmTheme",
      -- ollama_url = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
      -- open_ai_url = os.getenv("OPENAI_API_HOST") or "https://api.openai.com",
      -- open_ai_token = os.getenv("OPENAI_API_KEY") or "",
    },
  },

  -- OGPT configuration
  {
    "huynle/ogpt.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<leader>og", ":OGPT<CR>", desc = "OGPT" },
    },
    opts = {
      default_provider = "ollama",
      providers = {
        ollama = {
          -- api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
          -- api_key = os.getenv("OLLAMA_API_KEY") or "",
          model = {
            name = "mistral",
          },
        },
        openai = {
          model = {
            name = "undi95/toppy-m-7b:free",
          },
        },
      },
      popup_layout = {
        -- default = "right",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- ChatGPT Configuration
  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<leader>oc", ":ChatGPT<CR>", desc = "ChatGPT" },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },

    opts = {
      openai_params = {
        model = "undi95/toppy-m-7b:free",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4096,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    },
  },
}
