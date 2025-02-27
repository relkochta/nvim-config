return {
  {
    "nvim-neorg/neorg",
    version = "v7.0.0", -- pin to pre-luarocks version
    build = ":Neorg sync-parsers",
    priority = 30, -- should load after treesitter
    ft = "norg",
    cmd = "Neorg",
    keys = {
      { "<leader>n", "<cmd>Neorg index<cr>", desc = "Open Neorg" },
      { "<leader>N", "<cmd>Neorg return<cr>", desc = "Close Neorg" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      })

      -- add neorg-specific options
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        callback = function()
          -- enable word wrap
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true

          -- create localleader keybindings
          local buf = vim.api.nvim_get_current_buf()
          vim.keymap.set("n",
            "<localleader>c",
            "<cmd>Neorg toggle-concealer<cr>",
            { desc = "Toggle concealer",
              buffer = buf,
              noremap = false
            })
        end,
      })
    end,
  },
}

