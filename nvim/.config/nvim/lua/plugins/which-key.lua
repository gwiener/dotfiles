return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    -- longer delay so it stays out of the way for fast typers (default 200)
    delay = 500,
    win = {
      border = "single",
      title = false,
    },
    icons = {
      group = "+",
      mappings = false,
    },
    show_help = false,
    show_keys = false,
    -- group labels for your existing leader keys
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>t", group = "Tree" },
    },
  },
  keys = {
    { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps" },
  },
}
