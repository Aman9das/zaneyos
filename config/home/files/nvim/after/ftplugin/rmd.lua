vim.opt.conceallevel = 0 -- No hiding special characters

-- keymaps
vim.keymap.set("n", "<leader>qa", ":QuartoActivate", { desc = "quarto activate" })
vim.keymap.set("n", "<leader>qP", ":lua require'quarto'.quartoPreview()<cr>", { desc = "quarto preview" }) -- preview the recently modified file.
vim.keymap.set("n", "<leader>qp", ":QuartoPreview %<cr>", { desc = "quarto preview current file" })
vim.keymap.set("n", "<leader>qc", ":lua require'quarto'.quartoClosePreview()<cr>", { desc = "quarto close" })
vim.keymap.set("n", "<leader>qh", ":QuartoHelp", { desc = "quarto help" })
vim.keymap.set("n", "<leader>qe", ":lua require'otter'.export()<cr>", { desc = "quarto export" })
vim.keymap.set("n", "<leader>qE", ":lua require'otter'.export(true)<cr>", { desc = "quarto export overwrite" })
vim.keymap.set("n", "<leader>qrr", ":QuartoSendAbove<cr>", { desc = "quarto run to cursor" })
vim.keymap.set("n", "<leader>qra", ":QuartoSendAll<cr>", { desc = "quarto run all" })

-- slime config
vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrapped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"

-- insert code chunk
local wk = require("which-key")

local is_code_chunk = function()
  local current, range = require("otter.keeper").get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
  insert_code_chunk("r")
end

local insert_py_chunk = function()
  insert_code_chunk("python")
end

-- normal mode
wk.register({
  ["<m-i>"] = { insert_r_chunk, "r code chunk" },
  ["<cm-i>"] = { insert_py_chunk, "python code chunk" },
  ["<m-I>"] = { insert_py_chunk, "python code chunk" },
}, { mode = "n", silent = true })
