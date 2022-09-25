local vi_mode_utils = require("feline.providers.vi_mode")

local M = { vi = {} }

M.vi.text = {
	n = "NORMAL",
	no = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	[""] = "V-BLOCK",
	c = "COMMAND",
	cv = "COMMAND",
	ce = "COMMAND",
	R = "REPLACE",
	Rv = "REPLACE",
	s = "SELECT",
	S = "SELECT",
	[""] = "SELECT",
	t = "TERMINAL",
}

function M.file_osinfo()
	local os = vim.bo.fileformat:upper()
	if os == "UNIX" then
		return ""
	elseif os == "MAC" then
		return ""
	else
		return ""
	end
end

function M.get_diag(severity)
	local count = vim.tbl_count(vim.diagnostic.get(0, {
		severity = severity,
	}))
	return (count > 0) and " " .. count .. " " or ""
end

function M.get_filename(component)
	local filename = require("lib.filename").format_filename(vim.fn.expand("%:."))
	local extension = vim.fn.expand("%:e")

	local icon = component.icon or require("nvim-web-devicons").get_icon(filename, extension, { default = true })

	return " " .. icon .. " " .. filename .. " " .. require("lib.buf").get_modified_string(0)
end

function M.get_mode_highlight()
	return {
		name = vi_mode_utils.get_mode_highlight_name(),
		fg = "base",
		bg = vi_mode_utils.get_mode_color(),
		style = "bold",
	}
end

return M
