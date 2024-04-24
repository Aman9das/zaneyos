-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.register({
  c = {
    t = {
      name = "terminal",
    },
  },
}, { prefix = "<leader>" })

vim.keymap.set(
  "n",
  "<leader>ctt",
  ":vsplit | terminal<cr>i",
  { desc = "terminal" }
)

vim.keymap.set("n", "<leader>ct", "", { desc = "terminal" })
vim.keymap.set(
  "n",
  "<leader>ctR",
  ":vsplit term://tput cup 100 0; R<cr>i",
  { desc = "terminal: R" }
)
vim.keymap.set(
  "n",
  "<leader>ctr",
  ":vsplit term://tput cup 100 0; radian --profile=~/.config/nvim/extras/.radian_profile<cr>i",
  {
    desc = "terminal: radian",
  }
)
vim.keymap.set(
  "n",
  "<leader>cti",
  ":vsplit term://ipython<cr>i",
  { desc = "terminal: ipython" }
)
vim.keymap.set(
  "n",
  "<leader>ctp",
  ":vsplit term://python<cr>i",
  { desc = "terminal: python" }
)
vim.keymap.set(
  "n",
  "<leader>ctj",
  ":vsplit term://julia<cr>i",
  { desc = "terminal: julia" }
)
