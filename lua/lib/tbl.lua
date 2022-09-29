---Get last element of table
---@param tbl table
---@return unknown
function _G.tbl_last(tbl)
	return tbl[#tbl]
end

---Return true if two arrays contain the same elements
---@param first table
---@param second table
function _G.tbl_matches(first, second)
	for _, value in pairs(second) do
		if not vim.tbl_contains(first, value) then
			return false
		end
	end
	return true
end
