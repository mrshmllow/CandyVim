local mason_null_ls = require("mason-null-ls")
local ensure_installed = {}

for _, pack in pairs(cvim.language_packs) do
	if pack.install then
		for _, thing in pairs(pack.install) do
			table.insert(ensure_installed, thing)
		end
	end
end

mason_null_ls.setup({
	ensure_installed = ensure_installed,
	automatic_installation = true,
})
