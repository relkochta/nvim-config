local pdf_viewer = "zathura"

local open_pdf = function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if not filepath:match("%.typ$") then
    return
  end
  local pdf_path = filepath:gsub("%.typ$", ".pdf")
  vim.uv.spawn(pdf_viewer, { args = { pdf_path } })
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    -- enable word wrap
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    -- create localleader keybindings
    local buf = vim.api.nvim_get_current_buf()
    vim.keymap.set("n",
      "<localleader>ll",
      open_pdf,
      { desc = "Open typst output PDF",
        buffer = buf,
        noremap = false
      })
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      my_servers = {
        tinymist = {
          settings = {
            formatterMode = "typstyle",
            exportPdf = "onSave",
            semanticTokens = "disable",
            compileStatus = "enable",
            completion = {
              triggerOnSnippetPlaceholders = false,
            },
          },
        },
      },
    },
  },
}
