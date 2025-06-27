local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.echo(txts)
  vim.api.nvim_echo(txts, false, {})
end

function M.clear(time)
  vim.defer_fn(function()
    vim.api.nvim_echo({}, false, {})
  end, time or 0)
end

function M.sleep(ms, callback)
  vim.defer_fn(callback, ms)
end

function M.autocmd(events, opts)
  vim.api.nvim_create_autocmd(events, opts)
end

function M.create_cmd(name, callback, opts)
  vim.api.nvim_create_user_command(name, callback, opts or {})
end

function M.run_build(commands)
  local os_name = vim.loop.os_uname().sysname

  local command
  if os_name == "Windows_NT" then
    command = commands.win
  elseif os_name == "Darwin" then
    command = commands.mac
  elseif os_name == "Linux" then
    command = commands.linux
  else
    M.echo { { "Unknown OS: " .. os_name, "ErrorMsg" } }
    return nil
  end

  return command
end

return M
