-- Install `debugpy` using `uv tool Install debugpy` and then check the path
-- ~/.local/bin/debugpy is the uv shim; the actual interpreter is in the tool venv
local DEBUGPY_PYTHON = vim.fn.expand("~/.local/share/uv/tools/debugpy/bin/python")

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "nvimtools/hydra.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-python").setup(DEBUGPY_PYTHON)
      require("nvim-dap-virtual-text").setup()
      dapui.setup()

      -- Auto open/close UI with debug sessions
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

      -- Per-project configs via .nvim.lua in project root
      vim.opt.exrc = true
      vim.opt.secure = true

      local map = function(keys, fn, desc)
        vim.keymap.set('n', keys, fn, { desc = desc })
      end
      
      local conditional = function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end
      
      local test_method = require("dap-python").test_method

      map('<leader>dc', dap.continue,          "Debug: continue/start")
      map('<leader>db', dap.toggle_breakpoint, "Debug: toggle breakpoint")
      map('<leader>dB', conditional,           "Debug: conditional breakpoint")
      map('<leader>do', dap.step_over,         "Debug: step over")
      map('<leader>di', dap.step_into,         "Debug: step into")
      map('<leader>dO', dap.step_out,          "Debug: step out")
      map('<leader>dq', dap.terminate,         "Debug: terminate")
      map('<leader>dr', dap.repl.open,         "Debug: REPL")
      map('<leader>du', dapui.toggle,          "Debug: toggle UI")
      map('<leader>dt', test_method,           "Debug: test method")
      map('<leader>de', dapui.eval,            "Debug: eval under cursor")
      vim.keymap.set('v', '<leader>de', dapui.eval, { desc = "Debug: eval selection" })

      require("hydra")({
        name = "Debug",
        hint = [[
  _o_ step over   _i_ step into   _O_ step out
  _c_ continue    _b_ breakpoint  _e_ eval
  _u_ toggle UI   _q_ terminate
        ]],
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = { position = "bottom", float_opts = { border = "rounded" } },
        },
        mode = "n",
        body = "<leader>dd",
        heads = {
          { "o", dap.step_over,         { desc = "step over" } },
          { "i", dap.step_into,         { desc = "step into" } },
          { "O", dap.step_out,          { desc = "step out" } },
          { "c", dap.continue,          { desc = "continue" } },
          { "b", dap.toggle_breakpoint, { desc = "breakpoint" } },
          { "e", dapui.eval,            { desc = "eval" } },
          { "u", dapui.toggle,          { desc = "toggle UI" } },
          { "q", dap.terminate,         { exit = true, desc = "terminate" } },
          { "<Esc>", nil,               { exit = true, desc = false } },
        },
      })
    end
  }
}
