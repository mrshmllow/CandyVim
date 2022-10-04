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
						globals = { "vim", "cvim" },
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

function M:null_ls()
	return {
		require("null-ls").builtins.formatting.stylua,
	}
end

M.insall = {
	"stylua",
}

return M
