local lsps = {
  "lua_ls",
  "ts_ls",
  "denols",
  "pyright"
}

local function onLsp(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  local buf = ev.buf
  local map = function(keys, fn, desc)
    vim.keymap.set('n', keys, fn, { buffer = buf, desc = desc })
  end

  map('gd', vim.lsp.buf.definition, "Go to definition")
  map('gy', vim.lsp.buf.type_definition, "Go to type definition")
  map('gi', vim.lsp.buf.implementation, "Go to implementation")
  map('gr', vim.lsp.buf.references, "Go to references")
  map('K', vim.lsp.buf.hover, "Hover docs")
  map('<leader>la', vim.lsp.buf.code_action, "Code action")
  map('<leader>lr', vim.lsp.buf.rename, "Rename symbol")

  vim.diagnostic.config({
    virtual_lines = {
      current_line = true
    }
  })
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
      dependencies = { "saghen/blink.cmp" },
      config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = onLsp
        })
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          },
        })
        lspconfig.pyright.setup({
          capabilities = capabilities,
          root_dir = function(fname)
            local pyproject = util.root_pattern("pyproject.toml")(fname)
            local git_root = util.root_pattern(".git")(fname)
            if git_root and pyproject and git_root ~= pyproject then
              local root_pyproject = git_root .. "/pyproject.toml"
              local f = io.open(root_pyproject, "r")
              if f then
                local content = f:read("*a")
                f:close()
                if content:find("uv.workspace") then
                  return git_root
                end
              end
            end
            return pyproject
          end,
          on_new_config = function(config, root_dir)
            local venv_python = root_dir .. "/.venv/bin/python"
            if vim.uv.fs_stat(venv_python) then
              config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                python = { pythonPath = venv_python }
              })
            end
          end,
        })
        lspconfig.denols.setup({
          capabilities = capabilities,
          root_markers = {"deno.json", "deno.jsonc"},
          root_dir = util.root_pattern("deno.json", "deno.jsonc"),
          init_options = true,
          lint = true
        })
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
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
