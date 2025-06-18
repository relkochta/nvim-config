return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      my_servers = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              completion = {
                callable = {
                  snippets = "add_parentheses",
                },
              },
            }
          }
        },
      },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, { name = "crates" })
        end,
      },
    },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
      -- locali(z|s)ation
      thousands_separator = ",",
    },
    config = function(_, opts)
      -- K hover keybind
      local docs_keybind = function()
        if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
          require("crates").show_popup()
        else
          vim.lsp.buf.hover()
        end
      end
      vim.keymap.set("n", "K", docs_keybind, { desc = "Show documentation" })

      require("crates").setup(opts)
    end,
  },
}
