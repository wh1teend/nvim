local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

return {
	vtsls = {
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
							configNamespace = "typescript",
						},
					},
				},
			},
		},

		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
		},
	},

	vue_ls = {
		on_init = function(client)
			local unpack = unpack or table.unpack

			client.handlers["tsserver/request"] = function(_, result, context)
				local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
				if #clients == 0 then
					vim.notify(
						"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
						vim.log.levels.ERROR
					)
					return
				end

				local ts_client = clients[1]

				local param = unpack(result)
				local id, command, payload = unpack(param)

				ts_client:exec_cmd({
					title = "vue_request_forward",
					command = "typescript.tsserverRequest",
					arguments = {
						command,
						payload,
					},
				}, { bufnr = context.bufnr }, function(_, r)
					local response_data = { { id, r.body } }
					---@diagnostic disable-next-line: param-type-mismatch
					client:notify("tsserver/response", response_data)
				end)
			end
		end,
	},
}
