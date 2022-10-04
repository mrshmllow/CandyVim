local M = {}

function M.load_config()
	local ok = pcall(dofile, get_config_file())

	if not ok then
		cvim._message = " Couldn't load your config!"
	end

	-- `cvim.leader`
	local leader = vim.F.if_nil(cvim.leader, " ")

	if leader == "space" then
		vim.g.mapleader = " "
	else
		vim.g.mapleader = leader
	end

	-- `cvim.darkmode`
	local background = vim.F.if_nil(cvim.darkmode, " ") and "dark" or "light"

	if background ~= vim.o.background then
		if refresh_catppuccin and refresh_feline then
			-- Manually using vim.cmd(":set bacground.. wasnt working
			refresh_catppuccin(background)
			refresh_feline(background)
		end

		vim.o.background = background
	end

	cvim.enabled_modules = vim.F.if_nil(cvim.enabled_modules, {})
	cvim.language_packs = vim.F.if_nil(cvim.language_packs, { "lua" })

	local extra, sync_required = require("modules"):refresh()

	local plugins = require("plugins").get_plugins(extra)

	require("load_plugins"):init(plugins)

	if sync_required then
		require("plugins"):sync()
	end

	vim.cmd(":doautocmd User CandyEnter")
end

return M
