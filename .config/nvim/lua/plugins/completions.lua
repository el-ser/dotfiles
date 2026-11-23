return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- triggers when entering insert mode
  dependencies = {
    -- TODO: configure this
    -- "hrsh7th/cmp-buffer",           -- source for text in buffer
    -- "hrsh7th/cmp-path",             -- source for file system paths
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippets
    "saadparwaiz1/cmp_luasnip", -- autocompletion for luasnip
    "rafamadriz/friendly-snippets", -- multi language snippets (vscode)
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")

    -- load vscode style snippets from installed plugins (friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- add lsp servers (nvim-lspconfig) for autocomplete
        { name = "luasnip" }, -- snippets
        -- TODO: configure this
        -- { name = "buffer" },   -- text within buffers
        -- { name = "path" },     -- file system path
      }, { name = "buffer" }),
    })
  end,
}
