return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "Exafunction/windsurf.nvim",
      cmd = "Codeium",
      config = function()
        require "configs.ai.codeium"
      end,
    },
  },
  config = function(_, opts)
    local sources_to_add = {
      { name = "codeium" },
    }

    for i, source in ipairs(sources_to_add) do
      table.insert(opts.sources, i + 1, source)
    end

    opts.experimental = {
      ghost_text = false,
    }

    require("cmp").setup(opts)
  end,
}
