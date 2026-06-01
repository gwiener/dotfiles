local lsps = {
  "lua_ls",
  "ts_ls",
  "denols",
  "basedpyright",
  "svelte"
}

local function onLsp(ev)
  local buf = ev.buf
  local map = function(keys, fn, desc)
    vim.keymap.set('n', keys, fn, { buffer = buf, desc = desc })
  end

  map('gd', vim.lsp.buf.definition, "Go to definition")
  map('gy', vim.lsp.buf.type_definition, "Go to type definition")
  map('gi', vim.lsp.buf.implementation, "Go to implementation")
  map('gr', vim.lsp.buf.references, "Go to references")
  map('K', vim.lsp.buf.hover, "Hover docs")
  map('<leader>la', vim.lsp.buf.code_action, "Code actions")
  map('<leader>lf', function()
    require("conform").format({ formatters = { "ruff_fix" } })
  end, "Ruff fix")
  map('<leader>lr', vim.lsp.buf.rename, "Rename symbol")

  vim.diagnostic.config({
    virtual_lines = {
      current_line = true
    }
  })
end

return {
  {
    { "mason-org/mason.nvim",          opts = {} },
    { "mason-org/mason-lspconfig.nvim" },
    {
      "neovim/nvim-lspconfig",
      dependencies = { "saghen/blink.cmp" },
      config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = onLsp
        })
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        vim.lsp.config('lua_ls', {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          },
        })

        vim.lsp.config('basedpyright', {
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                indexing = true,
              }
            }
          },
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local pyproject = vim.fs.root(fname, "pyproject.toml")
            local git_root = vim.fs.root(fname, ".git")
            if git_root and pyproject and git_root ~= pyproject then
              local root_pyproject = git_root .. "/pyproject.toml"
              local f = io.open(root_pyproject, "r")
              if f then
                local content = f:read("*a")
                f:close()
                if content:find("uv.workspace") then
                  on_dir(git_root)
                  return
                end
              end
            end
            on_dir(pyproject)
          end,
          on_init = function(client)
            local venv_python = client.config.root_dir .. "/.venv/bin/python"
            if vim.uv.fs_stat(venv_python) then
              client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
                python = { pythonPath = venv_python }
              })
              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
          end,
        })

        vim.lsp.config('denols', {
          capabilities = capabilities,
          root_markers = { "deno.json", "deno.jsonc" },
          init_options = true,
          lint = true
        })

        vim.lsp.config('ts_ls', {
          capabilities = capabilities,
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fs.root(fname, { "deno.json", "deno.jsonc" }) then
              on_dir(nil)
              return
            end
            on_dir(vim.fs.root(fname, "package.json"))
          end,
          single_file_support = false
        })

        vim.lsp.enable(lsps)
      end
    }
  }
}
