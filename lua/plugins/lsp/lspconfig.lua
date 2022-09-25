local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local navic = require("nvim-navic")

require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_status.register_progress()

local on_attach = function(client, bufnr)
	if client.server_capabilities.colorProvider then
		require("document-color").buf_attach(bufnr, client)
	end

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	lsp_status.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

nvim_lsp.tsserver.setup({
	root_dir = nvim_lsp.util.root_pattern("package.json"),
	init_options = {
		lint = true,
	},
})
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.volar.setup({
	on_attach = on_attach,
})
nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.prismals.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.java_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
nvim_lsp.kotlin_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Update diagnostics while inserting
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})
