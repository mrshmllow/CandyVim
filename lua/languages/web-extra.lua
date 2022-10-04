local M = {}

M.lsp = {
	"tailwindcss",
	"svelte",
	"volar",
	"prismals",
}

function M:null_ls()
	local null_ls = require("null-ls")
	return {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
	}
end

M.install = {
	"prettierd",
	"eslint_d",
}

return M
