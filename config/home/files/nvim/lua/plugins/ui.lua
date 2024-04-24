return {
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "wrapped-compact",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_z = {
          function()
            return "󰔟 " .. os.date("%I:%M %p")
          end,
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["="] = "cd_root",
          ["o"] = "system_open",
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          -- vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
          -- Linux: open file in default application
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end,
        cd_root = function(state)
          local path = state.path -- this gives you the path

          -- do whatever you want to do here
          vim.fn.chdir(path)
        end,
      },
    },
  },
}
