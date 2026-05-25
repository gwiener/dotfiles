return {
  "ThePrimeagen/refactoring.nvim",
  commit = "b712180", -- 1e23fea uses vim.iter:unique() which requires nvim 0.12+
  dependencies = {
    "lewis6991/async.nvim",
  },
  lazy = false,
  config = function()
    local r = require("refactoring")
    -- r.setup({})
    local map = function(mode, keys, fn, desc)
      vim.keymap.set(mode, keys, fn, { expr = true, desc = desc })
    end

    map("x", "<leader>re", r.extract_func, "Extract function")
    map("x", "<leader>rv", r.extract_var, "Extract variable")
    map("x", "<leader>ri", r.inline_var, "Inline variable")
    map("n", "<leader>ri", r.inline_var, "Inline variable")
    map("n", "<leader>rI", r.inline_func, "Inline function")
  end
}
