return {
    "fasterius/simple-zoom.nvim",
    config = function ()
      vim.keymap.set('n', '<leader>z', require('simple-zoom').toggle_zoom)
    end,
}
