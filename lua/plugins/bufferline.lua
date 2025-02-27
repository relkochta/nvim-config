return {
  {
    "echasnovski/mini.bufremove",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "gn", "<Cmd>BufferLineCycleNext<cr>", desc = "Go to next buffer", },
      { "gp", "<Cmd>BufferLineCyclePrev<cr>", desc = "Go to previous buffer", },
    },
    opts = {
      options = {
        -- fix bug with neotree causing closing tab to close editor
        close_command = function(n) require("mini.bufremove").delete() end,
        right_mouse_command = function(n) require("mini.bufremove").delete() end,
        --always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        offsets = { -- From LazyVim; don't show above NeoTree
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      }
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
}
