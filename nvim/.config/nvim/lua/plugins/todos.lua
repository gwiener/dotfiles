return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)

    -- Filetypes without comment syntax where TODOs should highlight anywhere.
    local comment_less_filetypes = {
      markdown = true,
    }

    -- todo-comments has a single global `comments_only`. Keep it on (default)
    -- so TODOs in code files only match inside comments. But the filetypes
    -- above have no comment syntax, so treat every position in their buffers
    -- as a "comment" — that lets TODOs anywhere in them highlight.
    local hl = require("todo-comments.highlight")
    local is_comment = hl.is_comment
    hl.is_comment = function(buf, row, col)
      if comment_less_filetypes[vim.bo[buf].filetype] then
        return true
      end
      return is_comment(buf, row, col)
    end
  end,
}
