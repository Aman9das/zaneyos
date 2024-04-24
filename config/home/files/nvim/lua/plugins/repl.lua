return {
  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    "jpalardy/vim-slime",
    lazy = false,
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end
      vim.b["quarto_is_" .. "r" .. "_chunk"] = false
      Quarto_is_in_r_chunk = function()
        require("otter.tools.functions").is_otter_language_context("r")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      call v:lua.Quarto_is_in_r_chunk()

      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return [a:text]
      end

      endfunction
      ]])

      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
      -- vim.g.slime_menu_config = 1

      local function mark_terminal()
        if vim.b.terminal_job_id then
          print("terminal job id: " .. vim.b.terminal_job_id)
        end
      end

      vim.keymap.set(
        "n",
        "<leader>cM",
        mark_terminal,
        { desc = "Mark terminal job id" }
      )
    end,

    keys = {
      { "<leader><cr>", vim.fn["slime#send_cell"], desc = "Send code chunk" },
      { "<c-cr>", vim.fn["slime#send_cell"], desc = "Send code chunk" },
      {
        "<c-cr>",
        vim.fn["slime#send_cell"],
        mode = "i",
        desc = "Send code chunk",
      },
      {
        "<c-cr>",
        ":SlimeSend<cr>",
        mode = "v",
        desc = "Send code chunk",
      },
      {
        "<cr>",
        ":SlimeSend<cr>",
        mode = "v",
        desc = "Send code chunk",
      },
    },
  },
}
