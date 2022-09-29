local M = {}

M._required_plugins = {
	{
		"mrshmllow/document-color.nvim",
	},
	{
		"norcalli/nvim-colorizer.lua",
	},
}

M._load_on = "BufRead"

function M:init()
	local wk = require("which-key")

	require("document-color").setup({
		mode = "background",
	})

	local colorizer_config = module_is_enabled("lsp") and {
		"*",
		"!css",
		"!html",
		"!tsx",
	} or { "*" }

	require("colorizer").setup(colorizer_config)

	vim.api.nvim_create_autocmd("BufWinEnter", {
		pattern = get_config_file(),
		callback = function()
			require("colorizer").attach_to_buffer(0)
		end,
	})

	wk.register({
		["<leader>"] = {
			b = { c = { ":ColorizerAttachToBuffer<cr>", "Highlight color codes" } },
		},
	}, { silent = true, noremap = true })
end

return M
