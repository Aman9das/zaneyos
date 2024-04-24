-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.env.PATH = "~/.local/bin/:" .. vim.env.PATH
vim.g.mapleader = " "

-- case insensitive tab completion
vim.opt.wildignorecase = true

-- automatically load .nvim.lua
vim.opt_global.exrc = true

-- no hiding characters
vim.opt.conceallevel = 0 -- No hiding special characters

-- highlight character at 120
vim.opt.colorcolumn = "80"
