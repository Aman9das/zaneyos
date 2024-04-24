vim.b.slime_cell_delimiter = "#\\s\\=%%"

local wk = require("which-key")

-- insert mode
wk.register({
  ["<m-->"] = { " <- ", "assign" },
  ["<m-m>"] = { " |>", "pipe" },
}, { mode = "i" })
