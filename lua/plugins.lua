-- Packer bootstrap --
local M = {}

local fn = vim.fn
local install_path = join_paths(get_runtime_dir(), "site", "pack", "packer", "start", "packer.nvim")
local compile_path = join_paths(get_config_dir(), "plugin", "packer_compiled.lua")
local snapshot_path = join_paths(get_cache_dir(), "snapshots")

function M:init(plugins)
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
  end

  return require("packer").startup({
    function(use)
      use({ "lewis6991/impatient.nvim", config = "require('impatient')" })
      use("wbthomason/packer.nvim")

      vim.tbl_map(function(plugin)
        use(plugin)
      end, plugins)

      use({
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup({})
        end,
        event = "InsertEnter",
      })

      -- Meson
      use({
        "williamboman/mason.nvim",
        requires = {
          "williamboman/mason-lspconfig.nvim",
        },
        config = "require('plugins.tooling.mason')",
      })

      use({
        "jayp0521/mason-null-ls.nvim",
        config = "require('plugins.tooling.null-ls')",
        after = "null-ls.nvim",
      })

      -- LSP
      use({
        "neovim/nvim-lspconfig",
        config = "require('plugins.lsp.lspconfig')",
      })

      use({
        "jose-elias-alvarez/null-ls.nvim",
        config = "require('plugins.lsp.null-ls')",
      })

      use({
        "hrsh7th/nvim-cmp",
        config = function()
          local cmp = require("cmp")
          local lspkind = require("lspkind")

          cmp.setup({
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
            window = {
              -- completion = cmp.config.window.bordered(),
              -- documentation = cmp.config.window.bordered(),
            },
            mapping = {
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              ["<C-n>"] = cmp.mapping.select_next_item(),
              ["<C-p>"] = cmp.mapping.select_prev_item(),
            },
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "luasnip" },
            }, {
              { name = "buffer" },
            }),
            formatting = {
              format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = {
                  buffer = "[buf]",
                  nvim_lsp = "[lsp]",
                  luasnip = "[snip]",
                  nvim_lua = "[lua]",
                  latex_symbols = "[latex]",
                },
              }),
            },
          })

          -- Use buffer source for `/`
          cmp.setup.cmdline("/", {
            sources = {
              { name = "buffer" },
            },
          })

          -- Use cmdline & path source for ':'
          cmp.setup.cmdline(":", {
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              { name = "cmdline" },
            }),
          })

          -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
          -- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

          -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
        end,
        requires = {
          "hrsh7th/cmp-nvim-lsp", -- LSP source for CMP
          "hrsh7th/cmp-path", -- Filesystem paths for CMP
          "hrsh7th/cmp-cmdline", -- Command sources for CMP
          "onsails/lspkind.nvim", -- Adds icons

          -- Snips --
          "L3MON4D3/LuaSnip", -- LuaSnip
          "saadparwaiz1/cmp_luasnip", -- LuaSnip source for CMP
        },
        after = "LuaSnip",
      })

      use({
        "nvim-lua/lsp-status.nvim",
        config = function()
          require("lsp-status").config({})
        end,
      })

      -- Trouble
      use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup({
            signs = {
              -- icons / text used for a diagnostic
              error = "",
              warning = "",
              hint = "",
              information = "",
              other = "﫠",
            },
          })
        end,
        event = "BufRead",
      })

      use({
        "tiagovla/scope.nvim",
        config = function()
          require("scope").setup()
        end,
      })

      use({
        "feline-nvim/feline.nvim",
        config = "require('plugins.ui.feline')",
        after = { "nvim-navic", "catppuccin" },
      })

      use({
        "nanozuki/tabby.nvim",
        config = "require('plugins.ui.tabby')",
        after = { "catppuccin" },
      })

      use({
        "SmiteshP/nvim-navic",
        config = function()
          require("nvim-navic").setup({
            highlight = true,
          })
          vim.g.navic_silence = true
        end,
      })

      -- Git
      use({
        "lewis6991/gitsigns.nvim",
        config = "require('plugins.ui.gitsigns')",
        event = "BufRead",
      })

      -- Theme
      -- use 'joshdick/onedark.vim'
      -- use 'folke/tokyonight.nvim'
      use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = "require('plugins.ui.themes.catppuccin')",
        after = "nvim-navic",
      })

      use("Mofiqul/dracula.nvim")

      use({
        "shaunsingh/oxocarbon.nvim",
        run = "./install.sh",
      })

      -- Tree
      use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = "require('plugins.ui.tree')",
      })

      -- Comment
      use({
        "terrortylor/nvim-comment",
        config = function()
          require("nvim_comment").setup()
        end,
        event = "BufRead",
      })

      -- Telescope
      use({
        "nvim-telescope/telescope.nvim",
        config = "require('plugins.ui.telescope')",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope-ui-select.nvim",
          "nvim-telescope/telescope-node-modules.nvim",
          "nvim-telescope/telescope-file-browser.nvim",
          "nvim-telescope/telescope-github.nvim",
          {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
          },
          "nvim-telescope/telescope-frecency.nvim",
          "tami5/sqlite.lua",
        },
        event = { "BufRead", "User TelescopeNeeded", "CmdlineEnter" },
      })

      -- Sessions
      use({
        "Shatur/neovim-session-manager",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
          require("session_manager").setup({
            autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
          })
        end,
      })

      -- Indents
      use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
          vim.opt.list = true

          require("indent_blankline").setup({
            space_char_blankline = " ",
            show_current_context = true,
          })
        end,
        event = "BufRead",
      })

      -- Motion
      use({
        "phaazon/hop.nvim",
        config = "require('plugins.hop')",
        event = "BufRead",
      })

      -- Stay in place makes me happy
      use({
        "gbprod/stay-in-place.nvim",
        config = function()
          require("stay-in-place").setup()
        end,
        event = "BufRead",
      })

      use({
        "voldikss/vim-floaterm",
      })

      -- Folds
      use({
        "anuvyklack/fold-preview.nvim",
        requires = "anuvyklack/keymap-amend.nvim",
        config = function()
          require("fold-preview").setup()
        end,
        event = "BufRead",
      })

      use({
        "anuvyklack/pretty-fold.nvim",
        config = function()
          require("pretty-fold").setup({
            fill_char = " ",
          })
        end,
        event = "BufRead",
      })

      use({
        "folke/which-key.nvim",
        config = "require('keys')",
      })

      if packer_bootstrap then
        require("packer").sync()
      end
    end,
    config = {
      display = {
        open_fn = function()
          return require("packer.util").float({ border = "none" })
        end,
      },
      autoremove = true,
      package_root = join_paths(get_runtime_dir(), "site", "pack"),
      compile_path = compile_path,
      snapshot_path = snapshot_path,
    },
  })
end

function M.sync()
  require("packer").sync()
end

return M
