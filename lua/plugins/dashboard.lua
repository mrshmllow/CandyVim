local meta = require("lib.meta")
local db = require("dashboard")

db.custom_header = {
	[[        _    .  ,   .           .                      ]],
	[[    *  / \_ *  / \_      _  *        *   /\'__        *]],
	[[      /    \  /    \,   ((        .    _/  /  \  *'.   ]],
	[[ .   /\/\  /\/ :' __ \_  `          _^/  ^/    `--.    ]],
	[[    /    \/  \  _/  \-'\      *    /.' ^_   \_   .'\  *]],
	[[  /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \ ]],
	[[ /  `-.__ ^   / .-'.--\ =-=~_=-=~=^/  _ `--./ .-'  `-  ]],
	[[/        `.  / /       `.~-^=-=~=^=.-'      '-._ `._   ]],
}

local maps = {}

local function button(icon, desc, keys, action)
	table.insert(maps, {
		keys,
		action,
	})

	return {
		icon = icon,
		desc = desc,
		shortcut = keys,
		action = action,
	}
end

local function wrap_telescope(str)
	return function()
		require("packer").loader("telescope.nvim")
		vim.cmd(":Telescope " .. str)
	end
end

-- Set keymaps only when dashboard is active
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DashboardMappings", { clear = true }),
	pattern = "dashboard",
	callback = function()
		vim.tbl_map(function(map)
			if type(map[2]) == "string" then
				map[2] = map[2] .. "<cr>"
			end

			vim.keymap.set("n", map[1], map[2], { buffer = true, silent = true, nowait = true })
		end, maps)

		vim.keymap.set("n", "<esc>", ":qa<cr>", { buffer = true, nowait = true })
	end,
})

db.custom_center = {
	button("  ", "find                               ", "f", wrap_telescope("find_files")),
	button("  ", "search                             ", "/", wrap_telescope("live_grep")),
	button("  ", "recent                             ", "r", wrap_telescope("oldfiles")),
	button("  ", "new                                ", "n", ":DashboardNewFile"),
	button("  ", "last session                       ", "l", ":SessionManager load_last_session"),
	button("  ", "configure                          ", "c", ":e " .. get_config_file()),
}

db.custom_footer = { "CandyVim - " .. meta.get_candyvim_branch() .. " " .. meta.get_candyvim_version() }

if cvim._message then
	db.custom_footer = { cvim._message }
end

db.center_pad = 3
db.footer_pad = 2

local header_height = #db.custom_header
local center_height = (#db.custom_center * 2) + db.center_pad

local footer_height = 2 + db.footer_pad
if db.custom_footer ~= nil then
	footer_height = #db.custom_footer + db.footer_pad
end

local dashboard_height = header_height + center_height + footer_height

local function update_padding()
	local win_height = vim.fn.winheight(0)
	local padding = (win_height - dashboard_height) / 2
	db.header_pad = padding
end

update_padding()

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = update_padding,
})

local function refresh_hl(mode)
	local palette = require("catppuccin.palettes").get_palette(mode == "light" and "latte" or "mocha")

	vim.api.nvim_set_hl(0, "DashboardHeader", {
		fg = palette.mauve,
	})

	vim.api.nvim_set_hl(0, "DashboardCenter", {
		fg = palette.pink,
	})

	vim.api.nvim_set_hl(0, "DashboardShortCut", {
		fg = palette.mauve,
	})

	if cvim._message then
		vim.api.nvim_set_hl(0, "DashboardFooter", {
			fg = palette.red,
		})
	else
		vim.api.nvim_set_hl(0, "DashboardFooter", {
			fg = palette.flamingo,
		})
	end
end

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		refresh_hl(vim.v.option_new)
	end,
})

refresh_hl(vim.o.background)
