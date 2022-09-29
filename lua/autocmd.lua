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
	pattern = get_config_file(),
	callback = function()
		require("cvim.config").load_config()
	end,
})
