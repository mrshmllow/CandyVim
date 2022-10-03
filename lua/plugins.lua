local M = {}

function M.get_plugins(extra)
	local plugins = {
		{ "lewis6991/impatient.nvim", config = "require('impatient')" },
		{ "wbthomason/packer.nvim" },
		{ "nvim-lua/plenary.nvim" },

		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
			event = "InsertEnter",
		},

		{
			"williamboman/mason.nvim",
			config = "require('plugins.tooling.mason')",
		},

		{ "williamboman/mason-lspconfig.nvim" },

		{
			"jayp0521/mason-null-ls.nvim",
			config = "require('plugins.tooling.null-ls')",
			after = "null-ls.nvim",
		},

		-- LSP
		{
			"neovim/nvim-lspconfig",
			config = "require('plugins.lsp.lspconfig')",
			after = "mason.nvim",
		},

		{
			"jose-elias-alvarez/null-ls.nvim",
			config = "require('plugins.lsp.null-ls')",
		},

		{
			"hrsh7th/nvim-cmp",
			config = "require('plugins.cmp')",
			event = { "CmdlineEnter", "User FilteredBufRead" },
		},

		{ "hrsh7th/cmp-nvim-lsp", opt = true },
		{ "hrsh7th/cmp-path", opt = true },
		{ "hrsh7th/cmp-cmdline", opt = true },
		{ "onsails/lspkind.nvim" }, -- Having trouble

		{ "saadparwaiz1/cmp_luasnip", opt = true },

		{
			"nvim-lua/lsp-status.nvim",
			config = function()
				require("lsp-status").config({})
			end,
		},

		-- Trouble
		{
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					signs = {
						-- icons / text used for a diagnostic
						error = "",
						warning = "",
						hint = "",
						information = "",
						other = "﫠",
					},
				})
			end,
			event = "User FilteredBufRead",
		},

		{

			"tiagovla/scope.nvim",
			config = function()
				require("scope").setup()
			end,
		},

		{
			"feline-nvim/feline.nvim",
			config = "require('plugins.ui.feline')",
			after = { "nvim-navic", "catppuccin" },
		},

		{
			"nanozuki/tabby.nvim",
			config = "require('plugins.ui.tabby')",
			after = { "catppuccin" },
		},

		{
			"SmiteshP/nvim-navic",
			config = function()
				require("nvim-navic").setup({
					highlight = true,
				})
				vim.g.navic_silence = true
			end,
		},

		-- Git
		{
			"lewis6991/gitsigns.nvim",
			config = "require('plugins.git')",
			event = "User FilteredBufRead",
		},

		-- Theme
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = "require('plugins.catppuccin')",
			after = "nvim-navic",
		},

		-- Tree
		{
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = "require('plugins.ui.tree')",
		},

		-- Comment
		{
			"terrortylor/nvim-comment",
			config = function()
				require("nvim_comment").setup()
			end,
			event = "User FilteredBufRead",
		},

		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			config = "require('plugins.telescope')",
			event = { "User FilteredBufRead", "CmdlineEnter" },
		},

		{ "nvim-telescope/telescope-ui-select.nvim", opt = true },
		{ "nvim-telescope/telescope-node-modules.nvim", opt = true },
		{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
		{ "nvim-telescope/telescope-github.nvim", opt = true },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			opt = true,
		},
		{ "nvim-telescope/telescope-frecency.nvim", opt = true },
		{ "tami5/sqlite.lua", opt = true },

		-- Sessions
		{
			"Shatur/neovim-session-manager",
			config = function()
				require("session_manager").setup({
					autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				})
			end,
		},

		-- Indents
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				vim.opt.listchars:append("space:⋅")

				require("indent_blankline").setup({
					space_char_blankline = " ",
					show_current_context = true,
					filetype_exclude = { "dashboard" },
				})
			end,
			event = "User FilteredBufRead",
		},

		{
			"gbprod/stay-in-place.nvim",
			config = function()
				require("stay-in-place").setup()
			end,
			event = "User FilteredBufRead",
		},

		{
			"voldikss/vim-floaterm",
		},

		{
			"anuvyklack/pretty-fold.nvim",
			config = function()
				require("pretty-fold").setup({
					fill_char = " ",
				})
			end,
			event = "User FilteredBufRead",
		},

		{
			"folke/which-key.nvim",
			config = "require('keys')",
		},

		{
			"glepnir/dashboard-nvim",
			config = "require('plugins.dashboard')",
			after = "catppuccin",
		},

		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = "require('plugins.treesitter')",
		},
		{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
		{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
	}

	for _, extra_plugin in ipairs(extra) do
		table.insert(plugins, extra_plugin)
	end

	local default_snapshot_path = join_paths(get_cvim_base_dir(), "snapshots", "stable.json")
	local content = vim.fn.readfile(default_snapshot_path)
	local default_sha1 = vim.fn.json_decode(content)

	local get_default_sha1 = function(spec)
		local short_name, _ = require("packer.util").get_plugin_short_name(spec)
		return default_sha1[short_name] and default_sha1[short_name].commit
	end

	for _, spec in ipairs(plugins) do
		spec["commit"] = get_default_sha1(spec)
	end

	return plugins
end

return M
