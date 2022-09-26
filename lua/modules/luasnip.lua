local M = {}

M._required_plugins = {
  {
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
  },
}

function M:init()
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()

  vim.api.nvim_set_keymap(
    "i",
    "<Tab>",
    "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
    { expr = true }
  )

  vim.keymap.set("i", "<S-Tab>", function()
    luasnip.jump(-1)
  end, { silent = true })

  vim.keymap.set("s", "<Tab>", function()
    luasnip.jump(1)
  end, { silent = true })

  vim.keymap.set("s", "<S-Tab>", function()
    luasnip.jump(-1)
  end, { silent = true })
end

return M
