local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
	vim.opt.rtp:append(base_dir)
end

require("lib")
require("cvim.bootstrap"):init(base_dir)

vim.o.termguicolors = true

local ok = pcall(dofile, get_config_file())

local plugins, sync_required = {}, false

if not ok then
	cvim._message = "Couldn't read your config.lua!"
	print(cvim._message)
else
	plugins, sync_required = require("modules"):refresh()
end

require("plugins"):init(plugins)

if sync_required then
	require("plugins"):sync()
end

require("autocmd")

-- Leader --
vim.o.timeoutlen = 1000

vim.o.cursorline = true

-- Center --
vim.o.scrolloff = 10

-- Status bar --
vim.o.laststatus = 3
vim.o.showmode = false

vim.g.floaterm_borderchars = ""

-- Line numbers --
vim.o.number = true
vim.o.rnu = true

-- Add terminal colours --
vim.o.termguicolors = true

-- Column --
vim.o.signcolumn = "yes"

-- Icons --
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Splits --
vim.o.splitright = true -- split on the right

-- Folding with treesitter --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Folds --
vim.opt.foldlevelstart = 99

-- Tabs --
vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.expandtab = true

-- CMP --
vim.o.completeopt = "menu,menuone,noselect"
