local telescope = require("telescope")

telescope.setup({
	defaults = {},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		file_browser = {
			theme = "ivy",
			hijack_netrw = false,
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("node_modules")
telescope.load_extension("file_browser")
telescope.load_extension("gh")
telescope.load_extension("frecency")
