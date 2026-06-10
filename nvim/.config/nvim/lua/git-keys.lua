local telescope_builtin = require('telescope.builtin')
local gitsigns = require('gitsigns')

local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
end

map('<leader>gs', telescope_builtin.git_status,   'Git status')
map('<leader>gc', telescope_builtin.git_commits,  'Git commits')
map('<leader>gC', telescope_builtin.git_bcommits, 'Git buffer commits')
map('<leader>gb', telescope_builtin.git_branches, 'Git branches')

map('<leader>gd', '<cmd>DiffviewOpen<CR>', 'Git diff view')

map('<leader>gp', gitsigns.preview_hunk_inline,                        'Preview hunk (inline)')
map('<leader>gB', function() gitsigns.blame_line({ full = true }) end, 'Blame line (full)')
map('<leader>gl', function() gitsigns.blame_line() end,              'Blame line (summary)')

map(']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gitsigns.nav_hunk('next')
  end
end, 'Next hunk / diff change')

map('[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    gitsigns.nav_hunk('prev')
  end
end, 'Prev hunk / diff change')
