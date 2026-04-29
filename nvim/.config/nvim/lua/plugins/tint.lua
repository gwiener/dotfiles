return {
  "levouh/tint.nvim",
  config = function()
    -- github-theme's lualine integration does `hi! link StatusLine Normal`, making StatusLine
    -- a link in tint's dim namespace that resolves to tinted Normal (dark in inactive windows).
    -- Fix: after each ColorScheme (once all sync callbacks have run), break the link globally
    -- with explicit colors, then call tint.refresh() so it re-captures StatusLine as explicit.
    -- StatusLine is in ignore_patterns so tint stores the explicit colors without tinting them.
    local function fix_by_color_scheme()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      if not (normal.fg and normal.bg) then return end
      vim.api.nvim_set_hl(0, "StatusLine", { fg = normal.fg, bg = normal.bg })
      local tint = require("tint")
      -- In dark mode inactive windows should be lighter (positive tint); in light mode, darker.
      -- The modifier is less than that of Ghostty, to make it distinct between terminal panes.
      tint.setup({
        tint = vim.o.background == "dark" and 15 or -15,
        saturation = 0.6,
        tint_background_colors = true,
        highlight_ignore_patterns = { "WinSeparator", "StatusLine", "lualine*" }
      })
      tint.refresh()
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.schedule(fix_by_color_scheme) end,
    })
    vim.schedule(fix_by_color_scheme)
  end,
}

