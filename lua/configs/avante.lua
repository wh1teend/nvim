local options = {
  provider = "copilot",

  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub:get_active_servers_prompt()
  end,

  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,

  disabled_tools = {
    "list_files",
    "search_files",
    "read_file",
    "create_file",
    "rename_file",
    "delete_file",
    "create_dir",
    "rename_dir",
    "delete_dir",
    "bash",
  },
}

return options
