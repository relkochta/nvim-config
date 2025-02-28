return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- From LazyVim
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = "all",
    },
    config = function(_, opts)
      -- Don't compile all parsers on Android
      local termux = require("core.termux")
      if termux.is_termux() then
        opts.ensure_installed = { "c", "rust", "lua" }
        opts.auto_install = true
      end

      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
