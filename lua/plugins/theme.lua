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
    },
  },
  {
    -- auto-switch when GNOME theme changes
    "vimpostor/vim-lumen",
  },
}
