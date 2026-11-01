return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree reveal toggle=true<cr>", { desc = "File Explorer", silent = true })
  end,
}
