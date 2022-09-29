---Return true if file exists
---@param path string
---@return boolean
function _G.file_exists(path)
	local f = io.open(path, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

---Returns list of lines in file
---@param path string
---@return table
function _G.read_lines(path)
	if not file_exists(path) then
		return {}
	end

	local modules = {}
	for line in io.lines(path) do
		modules[#modules + 1] = line
	end
	return modules
end
