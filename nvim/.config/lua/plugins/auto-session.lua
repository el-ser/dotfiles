return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore = false,
    })

    -- keymaps
    local map = vim.keymap.set
    map("n", "<leader>sr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
    map("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Save session" })
  end,
}
