return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      my_servers = {
        clangd = {
          cmd = {
            "clangd",
            "--function-arg-placeholders=0",
          },
        },
      },
    },
  },
}
