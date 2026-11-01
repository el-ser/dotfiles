return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim", -- automatically installs lsp
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- automatically installs non-lsp (formatters)
      "neovim/nvim-lspconfig", -- registers vim.lsp.config(...) before mason-lspconfig auto-enables
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()

      -- Per-server settings (must run before mason-lspconfig auto-enables them).
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            buildFlags = { "-tags=integration,engine,nodeagent,guestagent,gateway,sdk_e2e" },
            gofumpt = true,
            staticcheck = true,
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "bashls", -- bash
          "buf_ls", -- protobuf
          "cssls", -- css
          "dockerls", -- dockerfile
          "eslint", -- javascript/typescript linter
          "golangci_lint_ls", -- golang
          "gopls", -- golang
          "graphql", -- graphql
          "jsonls", -- json
          "lua_ls", -- lua
          "marksman", -- markdown
          "prismals", -- prisma
          "sqlls", -- sql
          "tailwindcss", -- tailwind css
          "taplo", -- toml
          "ts_ls", -- typescript/javascript
          "yamlls", -- yaml
        },
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "sql-formatter", -- sql formatter
          "eslint_d",
          "shfmt",
          "sql-formatter",
          "yamlfmt",
          "goimports", -- golang formatter
        },
      })

      -- mason
      vim.keymap.set("n", "<leader>lm", ":Mason<cr>", { desc = "Mason", silent = true })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true }, -- handles files imports
      { "folke/neodev.nvim", opts = {} }, -- adds neovim lsp
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local map = vim.keymap.set

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          -- lsp
          opts.desc = "Hover"
          map("n", "K", vim.lsp.buf.hover, opts)
          opts.desc = "Go to Definition"
          map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
          opts.desc = "Go to Declaration"
          map("n", "gD", vim.lsp.buf.declaration, opts)
          opts.desc = "References"
          map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
          opts.desc = "Code Actios"
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
