local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local navic = require("nvim-navic")

lsp_status.register_progress()

local on_attach = function(client, bufnr)
	if module_is_enabled("colour") and client.server_capabilities.colorProvider then
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

for _, language_name in pairs(cvim.language_packs) do
	local language_def = require("languages." .. language_name)

	for _, server in pairs(language_def.lsp) do
		local config = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		if type(server) == "string" then
			nvim_lsp[server].setup(config)
		else
			config = vim.tbl_extend("error", config, server[2] == nil and {} or server[2])

			nvim_lsp[server[1]].setup(config)
		end
	end
end

-- Update diagnostics while inserting
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})
