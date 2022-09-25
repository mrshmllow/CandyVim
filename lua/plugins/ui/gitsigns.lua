local gitsigns = require("gitsigns")

vim.api.nvim_create_user_command("ToggleBlame", function()
	gitsigns.toggle_current_line_blame()
end, {})

gitsigns.setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local wk = require("which-key")

		wk.register({
			g = {
				name = " Git",
				a = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
				r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" },
				s = { gs.stage_buffer, "Stage whole buffer" },
				u = { gs.undo_stage_hunk, "Undo stage hunk" },
				R = { gs.reset_buffer, "Reset whole buffer" },
				p = { gs.preview_hunk, "Preview hunk" },
				d = { gs.diffthis, "View diff" },
        t = { ":ToggleBlame<CR>", "Toggle Blame" },
			},
		}, { prefix = "<leader>", buffer = bufnr })

		wk.register({
			g = {
				name = " Git",
				a = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
				r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" },
			},
		}, { prefix = "<leader>", buffer = bufnr, mode = "v" })
	end,
})
