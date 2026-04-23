return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  init = function()
    vim.opt.conceallevel = 2
  end,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    -- see https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "MIND",
        path = "~/MIND/",
      },
    },
    ui = {
      hl_groups = {
        ObsidianHighlightText = {
          bg = "#bdaa68"
        }
      }
    }
  },
}
