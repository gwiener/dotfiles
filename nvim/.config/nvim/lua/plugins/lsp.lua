local lsps = {
  "lua_ls",
  "ts_ls",
  "denols",
  "pyright"
}

local function onLsp(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client:supports_method('textDocument/completion') then
    vim.opt.completeopt = { 'menu', 'menuone','noinsert','fuzzy','popup' }
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    vim.keymap.set('i', '<C-Space>', function()
      vim.lsp.completion.get()
    end)
    vim.diagnostic.config({
      virtual_lines = {
        current_line = true
      }
    })
  end
end

return {
  {
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim",
--      opts = {
--        ensure_installed = lsps,
--        automatic_installation = false
--      }
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = onLsp
        })
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          },
        })
        lspconfig.pyright.setup({})
        lspconfig.denols.setup({
          root_markers = {"deno.json", "deno.jsonc"},
          root_dir = util.root_pattern("deno.json", "deno.jsonc"),
          init_options = true,
          lint = true
        })
        lspconfig.ts_ls.setup({
          root_dir = function (filename, bufnr)
            local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.json")(filename);
            if denoRootDir then
              return nil;
            end
            return lspconfig.util.root_pattern("package.json")(filename);
          end,
          -- root_dir = util.root_pattern("package.json"),
          single_file_support = false
        })
      end
    }
  }
}
