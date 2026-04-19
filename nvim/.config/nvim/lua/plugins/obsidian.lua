return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  init = function()
    vim.opt.conceallevel = 2
  end,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "MIND",
        path = "~/MIND/",
      },
    },
  },
}
