-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })
vim.api.nvim_create_autocmd({ "DirChanged", "SessionLoadPost" }, {
  group = augroup,
  desc = "Run lua file after loading session",
  callback = function(args)
    local contents = vim.secure.read(string.format("%s/.nvim.lua", args.file))
    if contents then
      assert(loadstring(contents))()
      print("Loaded local neovim config.")
    end
  end,
})
