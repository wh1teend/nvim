return function()
	local function canonical(path)
		return vim.uv.fs_realpath(path) or path
	end

	return function(markers, bufnr)
		bufnr = bufnr or 0
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name ~= "" and vim.bo[bufnr].buftype == "" then
			local file = vim.fn.fnamemodify(name, ":p")
			if markers and #markers > 0 then
				local root = vim.fs.root(file, markers)
				if root then
					return canonical(root)
				end
			end
			return canonical(vim.fs.dirname(file))
		end

		return canonical(vim.fn.getcwd())
	end
end
