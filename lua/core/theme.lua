-- Set colorscheme to dracula
vim.cmd[[colorscheme catppuccin]]

-- disable transparent background for lualine
local custom_catppuccin = function ()
  -- Use catppuccin's internal "utils" lualine theme; this isn't ideal,
  -- but for whatever reason, returning require("lualine.themes.catppuccin")
  -- leads to lualine light/dark theme not changing automatically
  local catppuccin = require("catppuccin.utils.lualine")(require("catppuccin").flavour)
  local palette = require("catppuccin.palettes").get_palette()
  catppuccin.normal.c.bg = palette.mantle
  return catppuccin
end
require("lualine").setup {
  options = {
    theme = custom_catppuccin,
  }
}
