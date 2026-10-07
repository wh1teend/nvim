local M = {}

function M.setup()
	local utils = require("utils")

	utils.create_cmd("ShowOS", function()
		utils.echo({ { "OS: " .. vim.uv.os_uname().sysname, "Normal" } })
	end, {})
end

return M
