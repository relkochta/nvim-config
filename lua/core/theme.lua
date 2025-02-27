-- Set colorscheme to dracula
vim.cmd[[colorscheme catppuccin]]

-- Enable for lualine as well
require("lualine").setup {
  options = {
    theme = "catppuccin",
  }
}
