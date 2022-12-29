local M = {}

M.lsp = {
	{
		"tailwindcss",
		{
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						},
					},
				},
			},
		},
	},
	"svelte",
	"volar",
	"prismals",
	"graphql",
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
	"graphql-language-service-cli",
}

return M
