-- Project-local config for DOTS: show dotfiles/hidden files in neo-tree and telescope
-- (everything lives under .config/, so defaults hide most of the repo)

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_hidden = false,
    }
  }
})

require("telescope").setup({
  defaults = {
    hidden = true,
  },
  pickers = {
    find_files = { hidden = true },
    live_grep = { additional_args = { "--hidden" } },
  },
  extensions = {
    live_grep_args = { additional_args = { "--hidden" } },
  },
})
require("telescope").load_extension("live_grep_args")
