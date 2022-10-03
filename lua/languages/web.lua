local M = {}

M.lsp = {
	"html",
	"cssls",
	{
		"tsserver",
		{
			root_dir = require("lspconfig").util.root_pattern("package.json"),
			init_options = {
				lint = true,
			},
		},
	},
}

return M
