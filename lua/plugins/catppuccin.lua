function _G.refresh_catppuccin(mode)
	vim.cmd("Catppuccin " .. (mode == "light" and "latte" or "mocha"))

	if module_is_enabled("sticky_context") then
		-- This is a bit of a hack
		local context = require("treesitter-context")

		context.toggle()
		context.toggle()
	end
end

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		refresh_catppuccin(vim.v.option_new)
	end,
})

require("catppuccin").setup({
	compile = {
		enabled = true,
	},
	integrations = {
		navic = {
			enabled = true,
			custom_bg = "",
		},
		hop = true,
		gitsigns = true,
		lsp_trouble = true,
		which_key = true,
		ts_rainbow = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
	},
	term_colors = true,
})

vim.g.catppuccin_flavour = vim.o.background == "dark" and "mocha" or "latte"

vim.cmd.colorscheme("catppuccin")
