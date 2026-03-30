return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    set_dark_mode = function()
      vim.cmd.colorscheme "github_dark_default"
      vim.schedule(function()
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#21212d" })
        vim.api.nvim_set_hl(0, "InsertCursor", { fg = "#ffffff", bg = "#79c0ff" })
      end)
    end,
    set_light_mode = function()
      vim.cmd.colorscheme "github_light_default"
      vim.schedule(function()
        vim.api.nvim_set_hl(0, "InsertCursor", { fg = "#ffffff", bg = "#0969da" })
      end)
    end
  }
}
