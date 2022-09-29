-- Terminals won't close without this --
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.o.bufhidden = "hide"
	end,
})

-- Markdown in mdx
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.mdx",
	callback = function()
		vim.o.filetype = "markdown"
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = join_paths(get_config_dir(), "config.lua"),
	callback = function()
		local ok, err = pcall(dofile, get_config_file())

		local plugins, sync_required = require("modules"):refresh()

		require("plugins"):init(plugins)

		if sync_required then
			require("plugins"):sync()
		end

		if not cvim._user_saw then
			print("Reload CandyVim for these changes to take effect")
			cvim._user_saw = true
		end
	end,
})
