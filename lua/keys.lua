-- NOTE: Most lazyloaded plugin keymaps are in their own plugins --

local wk = require("which-key")

wk.setup({
  layout = {
    align = "center",
  },
  icons = {
    breadcrumb = "»",
    separator = "",
    group = "",
  },
})

-- Misc --

vim.g.mapleader = " "

-- Terminal ESC
vim.api.nvim_set_keymap("t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true })

vim.api.nvim_set_keymap("v", "ga", ":lua vim.lsp.buf.range_code_action()<cr>", { silent = true })

vim.keymap.set({ "v", "n" }, "<leader>o", ":lua vim.lsp.buf.format()<cr>", { silent = true, desc = "Format File" })

vim.keymap.set("x", "<leader>p", "pgvy", { silent = true, desc = "Paste without yank" })

wk.register({
  -- System clipboard
  ["<C-p>"] = { '"+p', "Paste from system clipboard" },

  -- LSP
  K = { ":lua vim.lsp.buf.hover()<CR>", "LSP Hover" },

  -- Buffers
  ["<S-q>"] = { ":bd!<CR>", "Close buffer" },

  ["<C-s>"] = { ":w<CR>", "Save file" },
  ["<C-/>"] = { ":noh<CR>", "Clear highlight" },

  -- Move around windows
  ["<c-k>"] = { ":wincmd k<CR>", "Move window up" },
  ["<c-j>"] = { ":wincmd j<CR>", "Move window down" },
  ["<c-h>"] = { ":wincmd h<CR>", "Move window left" },
  ["<c-l>"] = { ":wincmd l<CR>", "Move window right" },

  g = {
    name = " Go to",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Run code action" },
  },

  c = {
    name = " Change",
    d = { ":lua vim.lsp.buf.rename()<CR>", "LSP Definition" },
  },

  ["<leader>"] = {
    ["."] = {
      ":NvimTreeToggle<cr>",
      "Toggle Tree",
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
  },
}, { silent = true, noremap = true })
