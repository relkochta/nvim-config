return {
  {
    "VonHeikemen/lsp-zero.nvim",
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
