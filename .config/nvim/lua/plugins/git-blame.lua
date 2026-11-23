return {
  "f-person/git-blame.nvim",
  config = function()
    require("gitblame").setup({
      enabled = false,

      -- keymaps
      vim.keymap.set({ "n", "v" }, "<leader>gb", "<cmd>GitBlameToggle<cr>", { silent = true }),
    })
  end,
}
