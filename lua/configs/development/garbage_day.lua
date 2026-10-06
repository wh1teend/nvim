return function(opts)
	local options = {
		aggressive_mode = false,
		excluded_lsp_clients = {},
		grace_period = 60 * 15,
		wakeup_delay = 250,
	}
	options = opts and vim.tbl_deep_extend("force", opts, options) or options
	require("garbage-day.config").set(options)
	local utils = require("garbage-day.utils")
	local timer = vim.uv.new_timer()
	local stopped = false
	local group = vim.api.nvim_create_augroup("GarbageDay", { clear = true })

	vim.api.nvim_create_autocmd("FocusLost", {
		group = group,
		callback = function()
			timer:stop()
			timer:start(
				vim.g.garbage_day_config.grace_period * 1000,
				0,
				vim.schedule_wrap(function()
					for _, client in ipairs(vim.lsp.get_clients()) do
						if not vim.tbl_contains(vim.g.garbage_day_config.excluded_lsp_clients, client.name) then
							client:stop(true)
						end
					end
					stopped = true
					if vim.g.garbage_day_config.notifications then
						utils.notify("lsp_has_stopped")
					end
				end)
			)
		end,
	})
	vim.api.nvim_create_autocmd("FocusGained", {
		group = group,
		callback = function()
			timer:stop()
			timer:start(
				vim.g.garbage_day_config.wakeup_delay,
				0,
				vim.schedule_wrap(function()
					if not stopped then
						return
					end
					local names, seen = {}, {}
					for _, profile in pairs(require("language").languages) do
						for _, entry in ipairs(profile.lsp or {}) do
							local name = entry[1]
							if not seen[name] and vim.lsp.is_enabled(name) then
								seen[name] = true
								names[#names + 1] = name
							end
						end
					end
					vim.lsp.enable(names)
					stopped = false
					if vim.g.garbage_day_config.notifications then
						utils.notify("lsp_has_started")
					end
				end)
			)
		end,
	})
	vim.api.nvim_create_autocmd("VimLeavePre", {
		group = group,
		callback = function()
			timer:stop()
			timer:close()
		end,
	})
end
