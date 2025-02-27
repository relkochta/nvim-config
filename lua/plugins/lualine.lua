return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      sections = {
        lualine_c = {
          { "navic" },
        },
        lualine_x = {
          "%S", -- showcmd
          "encoding",
          "fileformat",
          "filetype",
        }
      },
      extensions = {
        "neo-tree",
      },
    },
    config = function(_, opts)
      -- No need to show mode
      vim.o.showmode = false
      -- Show "showcmd" in lualine
      vim.o.showcmdloc = "statusline"

      -- Set up lualine for now;
      -- this might be called again to change the theme
      require("lualine").setup(opts)
    end,
  }
}
