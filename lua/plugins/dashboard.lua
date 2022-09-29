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

local function wrap_telescope(str)
	return ":doautocmd User TelescopeNeeded | " .. str
end

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find File", wrap_telescope("Telescope find_files<cr>")),
	dashboard.button("/", "  Find Word", wrap_telescope("Telescope live_grep<cr>")),
	dashboard.button("h", "  Recents", wrap_telescope("Telescope oldfiles<cr>")),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("l", "  Last Session", [[:SessionManager load_last_session<CR>]]),
	dashboard.button("c", "  Configure", ":e " .. join_paths(get_config_dir(), "config.lua") .. "<cr>"),
	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

if cvim._message then
	dashboard.section.footer.opts.hl = "Error"
	dashboard.section.footer.val = cvim._message
else
	dashboard.section.footer.opts.hl = "Identifier"
	dashboard.section.footer.val = "CandyVim - " .. meta.get_candyvim_branch() .. " " .. meta.get_candyvim_version()
end

alpha.setup(dashboard.config)
