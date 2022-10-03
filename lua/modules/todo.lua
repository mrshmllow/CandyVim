local M = {}

M._required_plugins = {
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	},
}

M._load_on = "User FilteredBufRead"

function M:init()
	require("todo-comments").setup({
		keywords = {
			HINT = { icon = " ", color = "_hint" },
		},
		colors = {
			_hint = { "Identifier", "#f2cdcd" },
		},
	})

	require("which-key").register({
		["<leader>"] = {
			f = {
				D = { ":TodoTelescope<cr>", "TODO's" },
			},
		},
	})
end

return M
