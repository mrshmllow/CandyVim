local M = {}

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
	local result = table.concat({ ... }, vim.loop.os_uname().version:match("Windows") and "\\" or "/")
	return result
end

---Get the full path to `$CANDYVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
	local cvim_runtime_dir = os.getenv("CANDYVIM_RUNTIME_DIR")
	if not cvim_runtime_dir then
		-- when nvim is used directly
		return vim.call("stdpath", "data")
	end
	return cvim_runtime_dir
end

---Get the full path to the candyvim config
---@return string
function _G.get_config_dir()
	local attempt = os.getenv("XDG_CONFIG_HOME")

	local cvim_config_dir = join_paths(attempt and attempt or join_paths(os.getenv("HOME"), ".config"), "cvim")
	if not cvim_config_dir then
		return vim.call("stdpath", "config")
	end
	return cvim_config_dir
end

---Get the full path to the candyvim cache
---@return string
function _G.get_cache_dir()
	local attempt = os.getenv("XDG_CACHE_HOME")

	local cvim_cache_dir = join_paths(attempt and attempt or join_paths(os.getenv("HOME"), ".cache"), "cvim")
	if not cvim_cache_dir then
		return vim.call("stdpath", "cache")
	end
	return cvim_cache_dir
end

function _G.get_config_file()
	return join_paths(get_config_dir(), "config.lua")
end

_G.cvim = {}

function M:init(base_dir)
	self.runtime_dir = get_runtime_dir()
	self.config_dir = get_config_dir()
	self.cache_dir = get_cache_dir()
	self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
	self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
	self.packer_cache_path = join_paths(self.config_dir, "plugin", "packer_compiled.lua")

	vim.fn.stdpath = function(what)
		if what == "cache" then
			return _G.get_cache_dir()
		end
		return vim.call("stdpath", what)
	end

	-- ---Get the full path to CandyVim's base directory
	-- ---@return string
	function _G.get_cvim_base_dir()
		return base_dir
	end

	-- user dir will override any other
	vim.opt.rtp:append(self.config_dir)

	if os.getenv("CANDYVIM_RUNTIME_DIR") then
		vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site"))
		vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site", "after"))
		vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
		vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

		vim.opt.rtp:remove(vim.call("stdpath", "config"))
		vim.opt.rtp:remove(join_paths(vim.call("stdpath", "config"), "after"))
		vim.opt.rtp:prepend(self.config_dir)
		vim.opt.rtp:append(join_paths(self.config_dir, "after"))

		vim.cmd([[let &packpath = &runtimepath]])
	end
end

return M
