if vim.g.neovide then
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0

	vim.g.gui_font_default_size = 12
	vim.g.gui_font_size = vim.g.gui_font_default_size
	vim.g.gui_font_face = "FiraCode Nerd Font Mono"

	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_size + delta
		RefreshGuiFont()
	end

	ResetGuiFont = function()
		vim.g.gui_font_size = vim.g.gui_font_default_size
		RefreshGuiFont()
	end

	-- Call function on startup to set default value
	ResetGuiFont()

	-- Keymaps

	local opts = { noremap = true, silent = true }

	vim.keymap.set({ "n", "i" }, "<C-+>", function()
		ResizeGuiFont(1)
	end, opts)

	vim.keymap.set({ "n", "i" }, "<C-_>", function()
		ResizeGuiFont(-1)
	end, opts)
end
