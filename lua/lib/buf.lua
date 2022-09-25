local M = {}

function M.get_modified_string(bufn)
	if vim.bo[bufn].modified then
		local modified_icon = "●"
		return modified_icon
	else
		return ""
	end
end

return M
