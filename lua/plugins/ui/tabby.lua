-- redraw for mode colours
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		require("tabby.tabline").render()
	end,
})

local function get_theme()
	local catppuccin = require("catppuccin.palettes").get_palette(vim.g.catppuccin_flavour)

	return vim.tbl_extend("error", {
		fill = {
			fg = catppuccin.text,
			bg = catppuccin.mantle,
			style = "bold",
		},

		head = {
			fg = catppuccin.text,
			bg = catppuccin.base,
			style = "bold",
		},

		current_tab = {
			fg = catppuccin.mauve,
			bg = catppuccin.base,
			style = "bold",
		},

		tab = {
			fg = catppuccin.subtext0,
			bg = catppuccin.base,
			style = "bold",
		},

		mode = {
			fg = catppuccin.base,
			bg = catppuccin[require("lib.vi_mode").get_mode_color()],
			style = "bold",
		},

		win = "TabLine",
		tail = "TabLine",
	}, catppuccin)
end

require("tabby.tabline").set(function(line)
	local theme = get_theme()

	return {
		{
			{
				" Candy ",
				hl = theme.mode,
			},
			line.sep(" ", {
				bg = theme[require("lib.vi_mode").get_mode_color()],
			}, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			return {
				line.sep("", hl, theme.fill),
				tab.number(),
				tab.name(),
				line.sep(" ", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		line.spacer(),
	}
end, {
	tab_name = {
		name_fallback = function(tabid)
			local win = require("tabby.module.api").get_tab_current_win(tabid)
			local buf = vim.api.nvim_win_get_buf(win)
			local filename = require("tabby.module.filename").unique(win)

			return require("lib.filename").format_filename(filename)
				.. " "
				.. require("lib.buf").get_modified_string(buf)
		end,
	},
})
