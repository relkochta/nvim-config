return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        noice = true,
        notify = true,
        lsp_trouble = true,
        which_key = true,
      },
      -- transparent_background needs some highlight fixups
      custom_highlights = function(colors)
        return {
          -- fixup telescope selection color
          TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
          -- clearer delineation for which-key
          WhichKeyNormal = { bg = colors.mantle },
          -- right-click menu
          Pmenu = { bg = colors.mantle },
        }
      end,
    },
  },
  {
    -- auto-switch when GNOME theme changes
    "vimpostor/vim-lumen",
  },
}
