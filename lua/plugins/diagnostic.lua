local orig_show = vim.diagnostic.handlers.virtual_text.show

vim.diagnostic.handlers.virtual_text.show = function(ns, bufnr, diagnostics, opts)
	for _, d in ipairs(diagnostics) do
		if d.source then
			d.message = string.format("[%s] %s", d.source, d.message)
		end
	end
	orig_show(ns, bufnr, diagnostics, opts)
end

return {
	"sontungexpt/better-diagnostic-virtual-text",
	event = "LspAttach",
	config = function()
		require("better-diagnostic-virtual-text").setup({
			inline = true,
			ui = { arrow = "→" },
		})
	end,
}
