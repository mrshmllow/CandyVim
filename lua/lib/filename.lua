local M = {}

function M.format_filename(filename)
	if filename == "" or filename == "[No Name]" then
		filename = "Unnamed"
	elseif vim.startswith(filename, "NvimTree_") then
		filename = "Tree"
	elseif vim.startswith(filename, "term://") then
		filename = "Terminal"
	end

	return filename
end

return M
