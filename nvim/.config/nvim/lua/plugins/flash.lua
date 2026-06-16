return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = { case_sensitive = false },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
