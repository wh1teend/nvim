local util = require "lspconfig.util"

local vue_language_server_path = vim.fn.stdpath "data"
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local is_vue_project = function(fname)
  local vue_config = util.root_pattern("nuxt.config.ts", "nuxt.config.js", "vite.config.ts", "vue.config.js")(fname)
  local vue_files = vim.fn.globpath(fname, "**/*.vue")
  return vue_config or vue_files ~= ""
end

return {
  vtsls = {
    root_dir = function(fname)
      if is_vue_project(fname) then
        return util.root_pattern("tsconfig.json", "package.json", ".git")(fname)
      end
      return nil
    end,

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
      client.handlers["tsserver/request"] = function(_, result, context)
        local clients = vim.lsp.get_clients { bufnr = context.bufnr, name = "vtsls" }
        if #clients == 0 then
          vim.notify("Could not find `vtsls` lsp client, `vue_ls` would not work without it.", vim.log.levels.ERROR)
          return
        end

        local ts_client = clients[1]

        local param = table.unpack(result)
        local id, command, payload = table.unpack(param)

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
