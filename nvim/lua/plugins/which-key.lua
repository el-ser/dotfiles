return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(_)
    local wk = require("which-key")
    wk.add({
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lazy" },
      { "<leader>s", group = "Sessions" },
      { "<leader>w", group = "Windows" },
      { "<leader>x", group = "Trouble" },
      { "gc", desc = "Comment toggle", mode = { "n", "v" } },
      { "gcc", desc = "Comment toggle line", mode = "n" },
    })
  end,
}
