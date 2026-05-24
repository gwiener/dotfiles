return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local actions = require("telescope.actions")
    local delete_buffer = actions.delete_buffer
    return {
      defaults = {
        path_display = { "filename_first" },
        layout_strategy = "flex",
        layout_config = {
          flex = {
            flip_columns = 120,
            flip_lines = 30,
          },
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = { ["<C-d>"] = actions.delete_buffer },
            n = {
              ["<C-d>"] = delete_buffer,
              ["dd"] = delete_buffer,
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Find file (git)" })
    vim.keymap.set('n', '<leader>fF', builtin.find_files, { desc = "Find file (all)" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find by grep" })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find symbol (file)" })
    vim.keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, { desc = "Find symbol (workspace)" })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = "Find references" })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Find diagnostics" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffer" })
  end
}
