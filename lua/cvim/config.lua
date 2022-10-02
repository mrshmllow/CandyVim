local M = {}

function M.load_config()
	local ok = pcall(dofile, get_config_file())

	if not ok then
		cvim._message = "Couldn't load your config!"
	end

	local extra, sync_required = require("modules"):refresh()

  local plugins = require("plugins").get_plugins(extra)

	require("load_plugins"):init(plugins)

	if sync_required then
		require("plugins"):sync()
	end

	---If not x, then f(y)
	---@param x any
	---@param y any
	local function default(x, y)
		if vim.F.if_nil(x) then
			return y
		end

		return x
	end

	-- `cvim.leader`
	vim.g.mapleader = default(cvim.leader, " ")

	-- `cvim.darkmode`
	local background = default(cvim.darkmode, " ") and "dark" or "light"

	if background ~= vim.o.background then
		if refresh_catppuccin and refresh_feline then
			-- Manually using vim.cmd(":set bacground.. wasnt working
			refresh_catppuccin(background)
			refresh_feline(background)
		end

		vim.o.background = background
	end
end

return M
