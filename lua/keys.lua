local wk = require("which-key")

-- Misc --

vim.g.mapleader = " "

-- K for documentation
vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- cd for change varaible name
vim.api.nvim_set_keymap("n", "cd", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true, desc = "Symbol" })

-- Terminal ESC
vim.api.nvim_set_keymap("t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true })

-- Save
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- clear save
vim.api.nvim_set_keymap("n", "<C-/>", ":noh<CR>", { noremap = true, silent = true })

-- Buffers --

-- Cycle >
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- Cycle <
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
-- Move >
vim.api.nvim_set_keymap("n", "<A-l>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true })
-- Move <
vim.api.nvim_set_keymap("n", "<A-h>", ":BufferLineMovePrev<CR>", { noremap = true, silent = true })
-- Close buffer
vim.api.nvim_set_keymap("n", "<S-q>", ":bd!<CR>", { noremap = true, silent = true })

-- Panels --

-- Move windows with ctrl
vim.api.nvim_set_keymap("n", "<c-k>", ":wincmd k<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-j>", ":wincmd j<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-h>", ":wincmd h<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-l>", ":wincmd l<cr>", { noremap = true, silent = true })

-- Nvim tree --
vim.keymap.set({ "n", "t" }, "<C-\\>", "<C-\\><C-n>:FloatermNew --name=scratch --title=Scratch<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<c- >", ":Telescope buffers<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "ga", ":lua vim.lsp.buf.range_code_action()<cr>", { silent = true })

vim.keymap.set({ "v", "n" }, "<leader>o", ":lua vim.lsp.buf.format()<cr>", { silent = true, desc = "Format File" })

vim.keymap.set("x", "<leader>p", 'pgvy', { silent = true, desc = "Paste without yank" })

vim.api.nvim_set_keymap("n", "<C-p>", '"+p', { silent = true })

-- Hop --
vim.api.nvim_set_keymap("n", "s", ":HopChar2MW<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "S", ":HopWordMW<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "?", ":HopPatternMW<cr>", { silent = true })

-- LuaSnip --
vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require('luasnip').jump(1)<cr>", { silent = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<cr>", { silent = true })

vim.api.nvim_set_keymap(
  "",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  ,
  {}
)

vim.api.nvim_set_keymap(
  "",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  ,
  {}
)
vim.api.nvim_set_keymap(
  "",
  "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  ,
  {}
)
vim.api.nvim_set_keymap(
  "",
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  ,
  {}
)

wk.register({
  ["<leader>"] = {
    -- d = {
    --   name = " Debug",
    --   b = { ":lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    --   ["<leader>"] = { ":lua require'dap'.continue()<cr>", "Continue" },
    --   o = { ":lua require'dap'.step_over()<cr>", "Step over" },
    --   i = { ":lua require'dap'.step_into()<cr>", "Step into" },
    -- },
    -- Telescope --
    f = {
      name = " Find",
      f = { ":Telescope find_files<cr>", "Find File" },
      d = { ":Telescope find_files cwd=~/.config/<cr>", "Find in ~/.config/" },
      t = { ":Telescope git_files<cr>", "Git Files" },
      h = { ":Telescope oldfiles<cr>", "Open Recent File" },
      b = { ":Telescope buffers<cr>", "Quickswitch buffers" },
      ["/"] = { ":Telescope live_grep<cr>", "Search" },
      m = { ":Telescope man_pages<cr>", "Search man pages" },
      c = { ":Telescope commands<cr>", "Search commands" },
    },
    -- Playerctl --
    m = {
      name = " Music",
      ["<leader>"] = { ":silent !playerctl play-pause<CR>:silent !playerctl status<CR>", "Pause" },
      n = { ":silent !playerctl next<CR>", "Next track" },
      p = { ":silent !playerctl previous<CR>", "Previous track" },
    },
    -- Floatterm stuff, prob will update --
    l = { ":FloatermNew --height=1.0 --width=1.0 lazygit<CR>", " Open lazygit" },
    -- Git & Github --
    h = {
      name = " Github",
      i = { ":Telescope gh issues<cr>", "View issues" },
      p = { ":Telescope gh pull_request<cr>", "View pull requests" },
      g = { ":Telescope gh gist<cr>", "My gists" },
      r = { ":Telescope gh run<cr>", "View workflow runs" },
    },
    t = {
      name = "裡Tabs",
      t = { ":tabnew +term<cr>", "Open terminal in new tab" },
      r = {
        function()
          local tab_name = require("tabby.feature.tab_name")

          local name = vim.fn.input("Tab Name: ", tab_name.get(0))
          tab_name.set(0, name)
        end,
        "Rename this tab",
      },
    },
    ["<leader>"] = {
      ":Telescope buffers<cr>",
      "Switch buffer",
    },
    ["."] = {
      ":NvimTreeToggle<cr>",
      "Toggle Tree",
    },
    ["/"] = {
      ":Telescope live_grep<cr>",
      "Search",
    },
    ["\\"] = {
      ":Telescope find_files<cr>",
      "Find File",
    },
  },
  g = {
    name = " Go to",
    d = { ":Telescope lsp_definitions<cr>", "Definition" },
    r = { ":Telescope lsp_references<cr>", "References" },
    D = { ":Telescope lsp_type_definitions<cr>", "Type definition" },
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Run code action" },
    b = { ":BufferLinePick<CR>", "Buffer" },
  },
}, { silent = true, noremap = true })
