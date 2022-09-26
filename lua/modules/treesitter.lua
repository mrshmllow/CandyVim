local M = {}

M._required_plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "windwp/nvim-ts-autotag",
  },
}

function M:init()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,

        keymaps = {
          ["af"] = { query = "@function.outer", desc = "a function" },
          ["if"] = { query = "@function.inner", desc = "a function" },

          ["ac"] = { query = "@comment.outer", desc = "a comment" },

          ["aC"] = { query = "@class.outer", desc = "a class" },
          ["iC"] = { query = "@class.inner", desc = "a class" },

          ["ax"] = { query = "@parameter.outer", desc = "a parameter" },
          ["ix"] = { query = "@parameter.outer", desc = "a parameter" },
        },

        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = {
            query = "@parameter.inner",
            desc = "Swap parameter forward",
          },
        },
        swap_previous = {
          ["<leader>A"] = { query = "@parameter.inner", desc = "Swap parameter backward" },
        },
      },
    },
  })
end

return M
