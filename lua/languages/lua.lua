local null_ls = require("null-ls")
local M = {}

M.lsp = {
	{
		"sumneko_lua",
		{
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
	},
}

M.null_ls = {
	null_ls.builtins.formatting.stylua,
}

M.insall = {
	"stylua",
}

return M
