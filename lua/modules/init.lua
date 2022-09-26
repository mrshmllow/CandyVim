local tbl = require("lib.tbl")
local M = {}

M._default_modules = {
  "colour",
  "luasnip",
  "treesitter",
  "sticky_context",
  "dashboard"
}

M.modules = {}
M.loaded_modules = {}

---Return true if CandyVim module is enabled
---@return boolean
function _G.module_is_enabled(name)
  return vim.tbl_contains(M.modules, name)
end

vim.api.nvim_create_user_command("CandyLoaded", function()
  print("Loaded CandyVim modules:", vim.inspect(M.modules))
end, {})

function M:init(disabled_modules)
  local required_plugins = {}
  local modules = vim.tbl_extend("error", M._default_modules, {})

  for _, module_name in pairs(modules) do
    if vim.tbl_contains(disabled_modules, module_name) then
      goto continue
    end

    table.insert(M.modules, module_name)
    local module = require("modules." .. module_name)

    if not module._required_plugins then
      goto continue
    end

    local first_plugin = module._required_plugins[1]

    first_plugin.config = module.init

    first_plugin.requires = vim.F.if_nil(first_plugin.requires, {})
    first_plugin.after = vim.F.if_nil(first_plugin.after, {})

    if module._load_on then
      first_plugin.event = module._load_on
    end

    for index, plugin in pairs(module._required_plugins) do
      if index > 1 then
        local packer_name = tbl.tbl_last(vim.split(plugin[1], "/"))

        plugin.event = module._load_on

        table.insert(first_plugin.after, packer_name)
        table.insert(first_plugin.requires, plugin)
      end
    end

    table.insert(required_plugins, first_plugin)

    ::continue::
  end

  return required_plugins
end

return M
