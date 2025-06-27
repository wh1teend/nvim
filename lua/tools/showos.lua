local helpers = require "../helpers"

helpers.create_cmd("ShowOS", function()
  helpers.echo { { "OS: " .. vim.loop.os_uname().sysname, "Normal" } }
end, {})
