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
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
