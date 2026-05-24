local function yank(expand_arg)
  local path = vim.fn.expand(expand_arg)
  vim.fn.setreg('+', path)
  vim.notify("Copied: " .. path)
end

vim.keymap.set('n', '<leader>yf', function() yank('%:t') end,  { desc = "Yank filename" })
vim.keymap.set('n', '<leader>yr', function() yank('%') end,    { desc = "Yank relative path" })
vim.keymap.set('n', '<leader>ya', function() yank('%:p') end,  { desc = "Yank absolute path" })
