local M = {}

M._required_plugins = {
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	},
}

M._load_on = "BufRead"

function M:init()
	require("todo-comments").setup({
		keywords = {
			HINT = { icon = " ", color = "hint" },
		},
		colors = {
			hint = { "Identifier", "#f2cdcd" },
		},
	})

	if module_is_enabled("telescope") then
		require("which-key").register({
			["<leader>"] = {
				f = {
					D = { ":TodoTelescope<cr>", "TODOs" },
				},
			},
		})
	end
end

return M
