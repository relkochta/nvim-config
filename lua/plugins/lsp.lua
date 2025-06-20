return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      -- Servers configured in my_servers will be automatically configured
      my_servers = {},
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      -- configure keybinds + navic at attach time
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          -- set lsp keybinds
          -- NOTE: this check is needed since crates.nvim will overwrite "K"
          if not vim.fn.mapcheck("K", "n") then
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
          end
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
          vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Open code actions" })
          vim.keymap.set("n", "<leader>m", vim.lsp.buf.format, { desc = "Format current file" })

          -- use telescope for LSP references, etc
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = buffnr, desc = "Go to references" })
          vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to object type definition" })
          vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Open file diagnostic list" })
          vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<cr>", { desc = "Open workspace diagnostic list" })

          -- Use navic for context hints
          if client.supports_method("textDocument/documentSymbol") then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })

      -- use pretty icons instead of 'W', 'E', ...
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
          },
        },
      })

      -- disable LSP logging
      vim.lsp.set_log_level("off")

      -- Set up language servers
      local servers = opts.my_servers
      for server, server_opts in pairs(servers) do
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local luasnip_snipmate = require("luasnip.loaders.from_snipmate")

      -- set up snippet engine
      luasnip_snipmate.lazy_load()
      -- functions for handling <Tab> and <S-Tab> with snippets
      -- taken from nvim-cmp docs
      local tab_mapping = cmp.mapping(function(fallback)
        local has_words_before = function()
          unpack = unpack or table.unpack
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })
      local s_tab_mapping = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      -- configuration for nvim-cmp
      return {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({}, {'i'}),
          ["<Down>"] = cmp.mapping.select_next_item({}, {'i'}),
          -- Use "Enter" for auto completion
          ["<cr>"] = cmp.mapping.confirm({select = false}),
          ["<Tab>"] = tab_mapping,
          ["<S-Tab>"] = s_tab_mapping,
        },
        window = {
          -- Borders around completion window
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          -- Enable lsp-kind for icons in completion window
          fields = {'abbr', 'kind', 'menu'},
          -- Formatter taken from LazyVim
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },
      }
    end,
  },
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      scope = "line",

      -- don't show diagnostics in insert mode
      toggle_event = { "InsertEnter" },
    },
  },


  -- Import language configs
  { import = "plugins.lang" },
}
