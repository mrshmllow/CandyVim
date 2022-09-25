local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Formatting
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint_d,

		-- Actions
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.code_actions.gitsigns,
	},
})
