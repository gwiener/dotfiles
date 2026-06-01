return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
            pytest_discover_instances = true, -- test discovery, not parsing
            dap = { justMyCode = true },
            cwd = function(_)
              return vim.g.neotest_python_cwd or vim.fn.getcwd()
            end,
          }),
        },
        summary = {
          mappings = {
            run        = "r",
            debug      = "d",
            expand     = "<CR>",
            expand_all = "e",
            jumpto     = "o",
            output     = "O",
            stop       = "q",
          },
        },
      })

      local map = function(keys, fn, desc)
        vim.keymap.set('n', keys, fn, { desc = desc })
      end

      map('<leader>tt', function() neotest.run.run() end, "Test: run nearest")
      map('<leader>tT', function() neotest.run.run(vim.fn.expand("%")) end, "Test: run file")
      map('<leader>tS', function() neotest.run.stop() end, "Test: stop")
      map('<leader>ts', function() neotest.summary.toggle() end, "Test: toggle summary")
      map('<leader>to', function() neotest.output_panel.toggle() end, "Test: toggle output panel")
      map('<leader>tO', function() neotest.output.open({ enter = true }) end, "Test: show output")
      map('<leader>td', function() neotest.run.run({ strategy = "dap" }) end, "Test: debug nearest")
    end,
  }
}
