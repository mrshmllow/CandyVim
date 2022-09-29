local Job = require("plenary.job")

local M = {}

function M.get_candyvim_version()
	local stdout = Job:new({
		command = "git",
		args = { "log", "--pretty=format:%h", "-1" },
		cwd = get_cvim_base_dir(),
		on_stderr = function(_, data)
			print(data)
		end,
	}):sync()

	return vim.F.if_nil(stdout[1], "")
end

function M.get_candyvim_branch()
	local stdout = Job:new({
		command = "git",
		args = { "branch", "--show-current" },
		cwd = get_cvim_base_dir(),
		on_stderr = function(_, data)
			print(data)
		end,
	}):sync()

	return vim.F.if_nil(stdout[1], "")
end

return M
