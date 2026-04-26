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

      map('<leader>dc', dap.continue,          "Debug: continue/start")
      map('<leader>db', dap.toggle_breakpoint,  "Debug: toggle breakpoint")
      map('<leader>dB', function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end,                                      "Debug: conditional breakpoint")
      map('<leader>do', dap.step_over,          "Debug: step over")
      map('<leader>di', dap.step_into,          "Debug: step into")
      map('<leader>dO', dap.step_out,           "Debug: step out")
      map('<leader>dq', dap.terminate,          "Debug: terminate")
      map('<leader>dr', dap.repl.open,          "Debug: REPL")
      map('<leader>du', dapui.toggle,           "Debug: toggle UI")
      map('<leader>dt', require("dap-python").test_method, "Debug: test method")
      map('<leader>de', dapui.eval,                        "Debug: eval under cursor")
      vim.keymap.set('v', '<leader>de', dapui.eval, { desc = "Debug: eval selection" })
    end
  }
}
