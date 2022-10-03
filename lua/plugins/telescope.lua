local telescope = require("telescope")
local wk = require("which-key")
local packer = require("packer")

packer.loader("telescope-ui-select.nvim")
packer.loader("telescope-node-modules.nvim")
packer.loader("telescope-file-browser.nvim")
packer.loader("telescope-github.nvim")
packer.loader("telescope-fzf-native.nvim")
packer.loader("telescope-frecency.nvim")
packer.loader("sqlite.lua")

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

wk.register({
	-- Telescope
	["<c- >"] = { ":Telescope buffers<cr>", "Quickswitch buffers" },

	["<leader>"] = {
		["<leader>"] = {
			":Telescope buffers<cr>",
			"Switch buffer",
		},
		["/"] = {
			":Telescope live_grep<cr>",
			"Search",
		},
		["\\"] = {
			":Telescope find_files<cr>",
			"Find File",
		},

		f = {
			name = " Find",
			f = { ":Telescope find_files<cr>", "Find File" },
			e = { ":Telescope find_files cwd=~/.config/<cr>", "Find in ~/.config/" },
			t = { ":Telescope git_files<cr>", "Git Files" },
			h = { ":Telescope oldfiles<cr>", "Open Recent File" },
			b = { ":Telescope buffers<cr>", "Quickswitch buffers" },
			["/"] = { ":Telescope live_grep<cr>", "Search" },
			m = { ":Telescope man_pages<cr>", "Search man pages" },
			c = { ":Telescope commands<cr>", "Search commands" },
			d = { ":Telescope diagnostics<cr>", "Diagnostics" },
		},

		-- Git & Github --
		h = {
			name = " Github",
			i = { ":Telescope gh issues<cr>", "View issues" },
			p = { ":Telescope gh pull_request<cr>", "View pull requests" },
			g = { ":Telescope gh gist<cr>", "My gists" },
			r = { ":Telescope gh run<cr>", "View workflow runs" },
		},
	},

	g = {
		d = { ":Telescope lsp_definitions<cr>", "Definition" },
		r = { ":Telescope lsp_references<cr>", "References" },
		D = { ":Telescope lsp_type_definitions<cr>", "Type definition" },
	},
}, { silent = true, noremap = true })
