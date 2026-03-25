return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "yavorski/lualine-macro-recording.nvim"
  },
  opts = {
    sections = {
      lualine_b = {
        -- Configuration for the 'filename' component
        {
          'filename',
          file_status = true, -- displays file status (readonly, modified, etc)
          path = 1,           -- 0: just filename, 1: relative path, 2: absolute path, 3: absolute path with ~
        }
      },
      lualine_c = { "macro_recording", "%S" },
    }
  }
}
