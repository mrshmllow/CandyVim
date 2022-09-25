vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "mocha"))
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

local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme", "r")
local result = handle:read("*a")
handle:close()

local new = result:gsub("\n[^\n]*(\n?)$", "%1")

if new == "'prefer-dark'" then
	vim.g.catppuccin_flavour = "mocha"
else
	vim.g.catppuccin_flavour = "latte"
end

vim.cmd.colorscheme("catppuccin")
