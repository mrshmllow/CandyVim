local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local meta = require("lib.meta")

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
	dashboard.button("/", "  Find Word", ":Telescope live_grep<cr>"),
	dashboard.button("h", "  Recents", ":Telescope oldfiles<cr>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("l", "  Last Session", [[:SessionManager load_last_session<CR>]]),
	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = "CandyVim - " .. meta.get_candyvim_version()

alpha.setup(dashboard.config)
