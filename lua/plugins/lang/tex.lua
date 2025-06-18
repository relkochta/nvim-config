return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      my_servers = {
        texlab = {},
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = true,
    ft = { "tex", "bib" },
    config = function()
      -- Block taken from LazyVim; disable conceal for TeX files, and mitigate conflicts
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          vim.wo.conceallevel = 2
        end,
      })
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      -- only open quickfix menu on *error*, not warning
      vim.g.vimtex_quickfix_open_on_warning = 0

      -- Tell VimTeX that treesitter is managing syntax highlighting
      vim.g.vimtex_syntax_enabled = 0

      -- Use Zathura instead of Evince
      --vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_forward_search_on_start = 0

      -- TeX file-specific options
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function(opts)
          -- Enable word wrap
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true

          -- Enable spell-check
          vim.opt_local.spell = true
        end,
      })
    end,
  },
}
