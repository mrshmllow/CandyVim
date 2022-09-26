local M = {}

M._required_plugins = {
  {
    "mrshmllow/document-color.nvim",
  },
  {
    "norcalli/nvim-colorizer.lua",
  },
}

M._load_on = "BufRead"

function M:init()
  require("document-color").setup({
    mode = "background",
  })

  local colorizer_config = module_is_enabled("lsp") and {
    "*",
    "!css",
    "!html",
    "!tsx",
  } or { "*" }

  require("colorizer").setup(colorizer_config)
end

return M

