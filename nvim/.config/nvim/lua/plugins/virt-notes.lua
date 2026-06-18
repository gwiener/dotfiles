return {
  "aaron-p1/virt-notes.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    hl_group = "DiagnosticInfo",
  },
  config = function(_, opts)
    require("virt-notes").setup(opts)
    require("telescope").load_extension("virt_notes")
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope").extensions.virt_notes.virt_notes()
    end, { desc = "Find notes" })
  end,
}
