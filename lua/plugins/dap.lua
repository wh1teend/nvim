return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap = require("dap")

			-- ✅ Настройка иконок для breakpoints
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = "◆",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "○",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapLogPoint", {
				text = "◎",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "→",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "",
			})

			-- ✅ Настройка цветов
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
			vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#31353f" })

			-- Ваши существующие настройки
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
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle Debug UI",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Conditional Breakpoint",
			},
			{
				"<leader>ds",
				function()
					require("dap").continue()
				end,
				desc = "Start/Continue",
			},
			{
				"<leader>dn",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
