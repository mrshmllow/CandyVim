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
	{
		"emmet_ls",
		{
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "xml" },
		},
	},
}

return M
