-- lua/plugins/lsp.lua
return {
  -- LSP Zero core (keybinding helpers, format-on-save helpers, cmp glue)
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
  },

  -- LSP + Mason + Neodev (use new Neovim 0.11 API: vim.lsp.config)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true, build = ":MasonUpdate" },
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} }, -- teaches lua_ls about Neovim & your config
      "VonHeikemen/lsp-zero.nvim",
    },
    config = function()
      -- 0) Diagnostics UX
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- 1) Capabilities (for nvim-cmp completion)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 2) LSP Zero: on_attach (keymaps + format-on-save)
      local lsp_zero = require("lsp-zero")
      lsp_zero.on_attach(function(_, bufnr)
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd",         vim.lsp.buf.definition,        "Go to definition")
        map("n", "gD",         vim.lsp.buf.declaration,       "Go to declaration")
        map("n", "gr",         vim.lsp.buf.references,        "References")
        map("n", "gi",         vim.lsp.buf.implementation,    "Implementation")
        map("n", "K",          vim.lsp.buf.hover,             "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename,            "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action,       "Code action")
        map("n", "[d",         vim.diagnostic.goto_prev,      "Prev diagnostic")
        map("n", "]d",         vim.diagnostic.goto_next,      "Next diagnostic")
        map("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

        lsp_zero.format_on_save({
          servers = {
            ["lua_ls"] = { "lua" },
            ["gopls"]  = { "go" },
            ["pyright"]= { "python" },
            ["ts_ls"]  = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
          },
        })
      end)

      -- 3) Neodev MUST run before defining lua_ls config
      require("neodev").setup({})

      --------------------------------------------------------------------
      -- 4) Define server configs with the NEW API (no lspconfig.setup()).
      --    This removes the deprecation warning in 0.11+.
      --------------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },                 -- fixes "undefined global vim"
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),   -- Neovim runtime + your config
            },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("gopls",  { capabilities = capabilities })
      vim.lsp.config("pyright",{ capabilities = capabilities })
      vim.lsp.config("ts_ls",  { capabilities = capabilities }) -- typescript-language-server
      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("yamlls", { capabilities = capabilities })

      --------------------------------------------------------------------
      -- 5) Ensure servers are installed; they will start with these configs.
      --------------------------------------------------------------------
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "gopls", "pyright", "ts_ls", "jsonls", "yamlls" },
        -- With the new API, we don't need handlers calling lspconfig.setup().
        -- mason-lspconfig will ensure the servers are available; Neovim will
        -- start them on-demand using the configs above.
      })
    end,
  },

  -- Completion stack (nvim-cmp + snippets)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "rafamadriz/friendly-snippets",
      "VonHeikemen/lsp-zero.nvim",
    },
    config = function()
      local lsp_zero   = require("lsp-zero")
      local cmp        = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      lsp_zero.extend_cmp()
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"]     = cmp_action.luasnip_supertab(),
          ["<S-Tab>"]   = cmp_action.luasnip_shift_supertab(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip"  },
        }, {
          { name = "path"     },
          { name = "buffer"   },
        }),
      })
    end,
  },
}

