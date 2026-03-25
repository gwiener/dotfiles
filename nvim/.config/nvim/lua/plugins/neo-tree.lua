return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {"3rd/image.nvim", opts = {}},
  },
  lazy = false,
  opts = {
    filesystem = {
      window = {
        mappings = {
          [","] = "toggle_node"
        }
      }
    }
  },
  config = function()
    vim.keymap.set('n', '<leader>tf', ':Neotree filesystem reveal left<CR>')
  end
}
