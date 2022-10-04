local Job = require("plenary.job")

local M = {}

function M.get_candyvim_version()
	local err = false

	local version = Job:new({
		command = "git",
		args = { "log", "--pretty=format:%h", "-1" },
		cwd = get_cvim_base_dir(),
		on_stderr = function()
			err = true
		end,
	}):sync()

	if err then
		local pac_err = false

		local pacman_version = Job:new({
			command = "pacman",
			args = { "-Q", "candyvim-git" },
			cwd = get_cvim_base_dir(),
			on_stderr = function()
				pac_err = true
			end,
		}):sync()

		if not pac_err then
			return vim.split(pacman_version[1], " ")[2]
		end

		return "unknown version"
	else
		local branch = Job:new({
			command = "git",
			args = { "branch", "--show-current" },
			cwd = get_cvim_base_dir(),
			on_stderr = function()
				err = true
			end,
		}):sync()

		return vim.F.if_nil(branch[1], "") .. " " .. vim.F.if_nil(version[1], "")
	end
end

return M
