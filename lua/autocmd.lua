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

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "dashboard" and vim.bo.filetype ~= "NvimTree" then
			-- Using nvim_exec_autocmds wasnt rly working
			vim.cmd(":doautocmd User FilteredBufRead")
		end
	end,
})
