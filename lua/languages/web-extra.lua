local null_ls = require("null-ls")
local M = {}

M.lsp = {
	"tailwindcss",
	"svelte",
	"volar",
	"prismals",
}

M.null_ls = {
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.code_actions.eslint_d,
}

return M
