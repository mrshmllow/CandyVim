local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"eslint_d",
	},
	automatic_installation = true,
})
