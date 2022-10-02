-- Packer bootstrap --
local M = {}

local fn = vim.fn
local install_path = join_paths(get_runtime_dir(), "site", "pack", "packer", "start", "packer.nvim")
local compile_path = join_paths(get_config_dir(), "plugin", "packer_compiled.lua")
local snapshot_path = join_paths(get_cache_dir(), "snapshots")

function M:init(plugins)
	local config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "none" })
			end,
		},
		autoremove = true,
		package_root = join_paths(get_runtime_dir(), "site", "pack"),
		compile_path = compile_path,
		snapshot_path = snapshot_path,
		-- snapshot = join_paths(get_cvim_base_dir(), "snapshots", "stable.json"),
	}

	if fn.empty(fn.glob(install_path)) > 0 then
		packer_bootstrap = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		-- config.snapshot = join_paths(get_cvim_base_dir(), "snapshots", "stable.json")
	end

	return require("packer").startup({
		function(use)
			vim.tbl_map(function(plugin)
				use(plugin)
			end, plugins)

			if packer_bootstrap then
				require("packer").sync()
			end
		end,
		config = config,
	})
end

function M.sync()
	require("packer").sync()
end

return M
