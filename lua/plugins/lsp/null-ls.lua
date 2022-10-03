local null_ls = require("null-ls")

local sources = {
	-- Actions
	null_ls.builtins.code_actions.gitsigns,
}

for _, language_name in pairs(cvim.language_packs) do
	local language_def = require("languages." .. language_name)

	if language_def.null_ls then
		for _, source in pairs(language_def.null_ls) do
			table.insert(sources, source)
		end
	end
end

null_ls.setup({
	sources = sources,
})
