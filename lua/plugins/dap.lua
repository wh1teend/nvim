return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local ok, dap = pcall(require, "dap")

      if not ok then
        return
      end

      dap.configurations.typescript = {
        {
          type = "node2",
          name = "node attach",
          request = "attach",
          program = "${file}",
          protocol = "inspector",
        },
      }

      dap.adapters.node2 = {
        type = "executable",
        command = "node-debug2-adapter",
        args = {},
      }
    end,

    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  {
    "rcarriga/nvim-dap-ui",

    config = function()
      require("dapui").setup()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,

    init = function()
      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { desc = "Dedug UI" })

      vim.keymap.set("n", "<Leader>db", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle" })

      vim.keymap.set("n", "<Leader>ds", function()
        require("dap").continue()
      end, { desc = "Continue" })

      vim.keymap.set("n", "<Leader>dn", function()
        require("dap").step_over()
      end, { desc = "Step Over" })
    end,

    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
}
