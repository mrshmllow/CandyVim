local M = {}

M._default_modules = {
	"colour",
	"luasnip",
	"treesitter",
	"sticky_context",
	"dashboard",
}

M.modules = {}

M.lock = {}

---Return true if CandyVim module is enabled
---@return boolean
function _G.module_is_enabled(name)
	return vim.tbl_contains(M.modules, name)
end

---@param path string
function M.write_lock(path)
	local file = io.open(path, "w+")

	vim.tbl_map(function(module_name)
		file:write(module_name, "\n")
	end, M.modules)
end

vim.api.nvim_create_user_command("CandyEnabled", function()
	print("Enabled CandyVim modules:", vim.inspect(M.modules))
end, {})

---Setup CandyVim modules
---@return table
---@return boolean
function M:refresh()
	local required_plugins = {}
	-- local modules = vim.tbl_extend("error", M._default_modules, cvim.enabled_modules)
	local lock_path = join_paths(get_runtime_dir(), "modules.lock")

	local lock = read_lines(lock_path)
	local requires_sync = false

	for _, module_name in pairs(cvim.enabled_modules) do
		local lock_contains = vim.tbl_contains(lock, module_name)

		-- if vim.tbl_contains(cvim.disabled_modules, module_name) then
		-- 	if lock_contains then
		-- 		requires_sync = true
		-- 	end
		--
		-- 	goto continue
		-- end

		if not lock_contains then
			requires_sync = true
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
				local packer_name = tbl_last(vim.split(plugin[1], "/"))

				plugin.event = module._load_on

				table.insert(first_plugin.after, packer_name)
				table.insert(first_plugin.requires, plugin)
			end
		end

		table.insert(required_plugins, first_plugin)

		::continue::
	end

	if requires_sync then
		M.write_lock(lock_path)
	end

	return required_plugins, requires_sync
end

return M
