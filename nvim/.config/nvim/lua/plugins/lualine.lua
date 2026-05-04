local function is_zoom_in()
    if vim.t['simple-zoom'] == nil then
        return ''
    elseif vim.t['simple-zoom']== 'zoom' then
        return '󰍉'
    end
end

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
        },
        { is_zoom_in }
      },
      lualine_c = { "macro_recording", "%S" },
    }
  }
}
