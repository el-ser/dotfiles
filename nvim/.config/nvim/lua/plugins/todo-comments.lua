return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    local todo_comments = require("todo-comments")
    todo_comments.setup({})

    -- keymaps
    local map = vim.keymap.set
    map("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })
    map("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
  end,
}
