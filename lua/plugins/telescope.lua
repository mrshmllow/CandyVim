local telescope = require("telescope")
local wk = require("which-key")

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
			q = {
				':lua require("telescope.actions").smart_send_to_qflist(vim.api.nvim_buf_get_number(0))<cr>:copen<cr>',
				" Save telescope to qflist",
			},
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
