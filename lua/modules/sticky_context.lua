local M = {}

M._required_plugins = {
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}

M._load_on = "BufRead"

function M:init()
	require("treesitter-context").setup()
end

return M
