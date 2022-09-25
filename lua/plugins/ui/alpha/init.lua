local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[        _    .  ,   .           .]],
	[[    *  / \_ *  / \_      _  *        *   /\'__        *]],
	[[      /    \  /    \,   ((        .    _/  /  \  *'.]],
	[[ .   /\/\  /\/ :' __ \_  `          _^/  ^/    `--.]],
	[[    /    \/  \  _/  \-'\      *    /.' ^_   \_   .'\  *]],
	[[  /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \]],
	[[ /  `-.__ ^   / .-'.--\ =-=~_=-=~=^/  _ `--./ .-'  `-]],
	[[/        `.  / /       `.~-^=-=~=^=.-'      '-._ `._]],
}
dashboard.section.header.opts = {
	hl = "Statement",
	position = "center",
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find File", ":Telescope find_files<cr>"),
	dashboard.button("g", "  Find Word", ":Telescope live_grep<cr>"),
	dashboard.button("h", "  Recents", ":Telescope oldfiles<cr>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("l", "  Last Session", [[:SessionManager load_last_session<CR>]]),
	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune

-- dashboard.config.opts.noautocmd = true

vim.cmd([[autocmd User AlphaReady echo 'ready']])

alpha.setup(dashboard.config)
