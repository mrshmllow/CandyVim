local fmt = string.format
local utils = require("plugins.ui.feline.util")
local vi_mode_utils = require("feline.providers.vi_mode")
local navic = require("nvim-navic")
local vi_mode_colours = require("lib.vi_mode")

local mocha = require("catppuccin.palettes").get_palette("mocha")
local latte = require("catppuccin.palettes").get_palette("latte")

local c = {
	default = { -- Stop highlight spill
		provider = "",
		hl = "StatusLine",
	},
	vimode = {
		provider = function()
			return string.format(" %s ", utils.vi.text[vim.fn.mode()])
		end,
		-- hl = vi_mode_hl,
		hl = function()
			return utils.get_mode_highlight()
		end,
		right_sep = { str = "" },
	},
	git = {
		branch = {
			provider = "git_branch",
			icon = " ",
			enabled = function()
				return vim.b.gitsigns_status_dict ~= nil
			end,
			left_sep = " ",
		},
	},
	file = {
		name = {
			statusline = {
				provider = function(component)
					return utils.get_filename(component)
				end,
				hl = {
					fg = "mauve",
					bg = "base",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			winbar = {
				provider = function()
					local type = vim.bo.filetype
					local filename = require("lib.filename").format_filename(vim.fn.expand("%:t"))

					return type == "NvimTree" and "Tree"
						or " " .. filename .. " " .. require("lib.buf").get_modified_string(0)
				end,
				enabled = function()
					local type = vim.bo.filetype
					if type ~= "alpha" then
						return true
					end

					return false
				end,
				hl = function()
					local type = vim.bo.filetype

					return {
						fg = "mauve",
						bg = type == "NvimTree" and "mantle" or "base",
						style = "bold",
					}
				end,
			},
		},
		type = {
			provider = function()
				return fmt(" %s ", vim.bo.filetype)
			end,
			hl = {
				fg = "base",
				bg = "lavender",
				style = "bold",
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "mantle",
					bg = "lavender",
				},
			},
		},
		format = {
			provider = function()
				return fmt(" %s", utils.file_osinfo())
			end,
			hl = {
				bg = "mantle",
			},
		},
		encoding = {
			provider = function()
				return fmt(" %s ", vim.bo.fileencoding)
			end,
			hl = {
				bg = "mantle",
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = function()
					local var = {
						fg = vi_mode_utils.get_mode_color(),
						bg = "mantle",
					}
					return var
				end,
			},
		},
	},
	lsp = {
		status = {
			provider = function()
				return require("lsp-status").status_progress()
			end,
			hl = {
				fg = "subtext0",
			},
		},
		context = {
			provider = function()
				local location = navic.get_location()

				if location ~= "" then
					return "> " .. location
				end

				return location
			end,
			enabled = function()
				return navic.is_available()
			end,
			hl = {
				bg = "base",
			},
		},
		errors = {
			provider = function()
				return utils.get_diag(vim.diagnostic.severity.ERROR)
			end,
			hl = {
				bg = "red",
				fg = "base",
			},
			left_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "red",
				},
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "yellow",
					bg = "red",
				},
			},
		},
		warnings = {
			provider = function()
				return utils.get_diag(vim.diagnostic.severity.HINT)
			end,
			hl = {
				bg = "yellow",
				fg = "base",
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "teal",
					bg = "yellow",
				},
			},
		},
		hints = {
			provider = function()
				return utils.get_diag(vim.diagnostic.severity.HINT)
			end,
			hl = {
				bg = "teal",
				fg = "base",
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "blue",
					bg = "teal",
				},
			},
		},
		info = {
			provider = function()
				return utils.get_diag(vim.diagnostic.severity.HINT)
			end,
			hl = {
				bg = "blue",
				fg = "base",
			},
			right_sep = {
				str = "",
				always_visible = true,
				hl = {
					fg = "lavender",
					bg = "blue",
				},
			},
		},
	},
	percentage = {
		active = {
			provider = function()
				return " " .. require("feline.providers.cursor").line_percentage() .. " "
			end,
			hl = function()
				return utils.get_mode_highlight()
			end,
			right_sep = {
				str = "",
				hl = function()
					local var = { fg = "base", bg = vi_mode_utils.get_mode_color() }
					return var
				end,
			},
		},
		inactive = {
			provider = function()
				return " " .. require("feline.providers.cursor").line_percentage() .. " "
			end,
			hl = function()
				return utils.get_mode_highlight()
			end,
			right_sep = {
				str = "",
				hl = function()
					local var = { fg = "base", bg = vi_mode_utils.get_mode_color() }
					return var
				end,
			},
			left_sep = {
				str = "",
				always_visible = true,
				hl = function()
					local var = {
						fg = vi_mode_utils.get_mode_color(),
						bg = "mantle",
					}
					return var
				end,
			},
		},
	},
	position = {
		provider = function()
			return fmt(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
		end,
		hl = function()
			return utils.get_mode_highlight()
		end,
	},
}

-- Initialize the components table
local components = {
	active = {
		{ -- Left
			c.vimode,
			c.git.branch,
			c.file.name.statusline,
			c.lsp.status,
			c.default,
		},
		{ -- Right
			c.lsp.errors,
			c.lsp.warnings,
			c.lsp.hints,
			c.lsp.info,
			c.file.type,
			c.file.format,
			c.file.encoding,
			c.percentage.active,
			c.position,
		},
	},
	inactive = {
		{
			c.vimode,
			c.file.name,
		},
		{
			c.percentage.inactive,
			c.position,
		},
	},
}

local latteTheme = vim.tbl_extend("error", {
	bg = latte.mantle,
	fg = latte.text,
}, latte)

local mochaTheme = vim.tbl_extend("error", {
	bg = mocha.mantle,
	fg = mocha.text,
}, mocha)

require("feline").setup({
	components = components,
	vi_mode_colors = vi_mode_colours.colours,
	theme = (vim.g.catppuccin_flavour == "mocha" and mochaTheme or latteTheme),
})

require("feline").winbar.setup({
	components = {
		active = {
			{
				c.file.name.winbar,
				c.lsp.context,
			},
		},
		inactive = {
			{
				c.file.name.winbar,
			},
		},
	},
	theme = (vim.g.catppuccin_flavour == "mocha" and mochaTheme or latteTheme),
})

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		if vim.v.option_new == "light" then
			require("feline").use_theme(latteTheme)
		else
			require("feline").use_theme(mochaTheme)
		end
	end,
})
