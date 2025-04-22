return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open file picker", },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Global search", },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Open buffer picker", },
      { "<leader>j", "<cmd>Telescope jumplist<cr>", desc = "Open jumplist picker", },
      { "<leader>g", "", desc = "Git", },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Open git file picker", },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Browse git commits", },
      { "<leader>gd", "<cmd>Telescope git_status<cr>", desc = "View git diff", },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
            -- Show preview even for small windows
            --preview_cutoff = 50,
          },
        },
      },
      pickers = {
        buffers = {
          -- sort buffers in order of last-use
          sort_lastused = true,
        },
        diagnostics = {
          theme = "dropdown",
          layout_config = {
            width = 0.9,
          },
        },
      },
      extensions = {
        file_browser = {
          mappings = {},
        },
      },
    },
    config = function(_, opts)
      local actions = require("telescope.actions")
      -- close on esc
      opts.defaults.mappings = { i = { ["<esc>"] = actions.close } }
      -- except for in the file browser
      opts.extensions.file_browser.mappings = { i = { ["<esc>"] = function() vim.cmd("stopinsert") end } }

      local telescope = require("telescope")
      telescope.setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<leader>e", "<cmd>Telescope file_browser<cr>", desc = "Open file explorer", },
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { "<leader>t", "<cmd>TodoTelescope<cr>", desc = "Open workspace TODOs listing", },
    },
  }
}

