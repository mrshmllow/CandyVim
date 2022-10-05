local M = {}

M._required_plugins = {
	{
		"nvim-treesitter/nvim-treesitter-context",
		module = "treesitter-context",
	},
}

M._load_on = "User FilteredBufRead"

function M:init()
	require("treesitter-context").setup()
end

return M
