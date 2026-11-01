return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        javascriptreact = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
        svelte = { "prettier", stop_after_first = true },
        css = { "prettier", stop_after_first = true },
        html = { "prettier", stop_after_first = true },
        json = { "prettier", stop_after_first = true },
        yaml = { "prettier", stop_after_first = true },
        markdown = { "prettier", stop_after_first = true },
        graphql = { "prettier", stop_after_first = true },
        liquid = { "prettier", stop_after_first = true },
        lua = { "stylua" },
        sql = { "sql_formatter" },
        nix = { "nixfmt" },
        proto = { "buf" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
  end,
}
