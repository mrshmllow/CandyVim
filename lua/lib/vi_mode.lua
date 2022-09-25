local M = {}

local mode_alias = {
	["n"] = "NORMAL",
	["no"] = "OP",
	["nov"] = "OP",
	["noV"] = "OP",
	["no"] = "OP",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "LINES",
	["Vs"] = "LINES",
	[""] = "BLOCK",
	["s"] = "BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT",
	[""] = "BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rx"] = "REPLACE",
	["c"] = "COMMAND",
	["cv"] = "COMMAND",
	["ce"] = "COMMAND",
	["r"] = "ENTER",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERM",
	["nt"] = "TERM",
	["null"] = "NONE",
}

M.colours = {
	-- Base modes are warmer colours
	NORMAL = "flamingo",
	INSERT = "pink",
	VISUAL = "flamingo",

	-- Lines and blocks are blues
	LINES = "teal",
	BLOCK = "sapphire",

	-- In my mind, red for danger ?
	REPLACE = "red",
	["V-REPLACE"] = "maroon",

	-- I don't know/use
	SELECT = "peach",
	ENTER = "teal",
	MORE = "teal",

	-- Terms and shells
	SHELL = "teal",
	TERM = "teal",
	COMMAND = "mauve",

	OP = "base",
	NONE = "base",
}

function M.get_vim_mode()
	return mode_alias[vim.api.nvim_get_mode().mode]
end

function M.get_mode_color()
	return M.colours[M.get_vim_mode()]
end

return M
