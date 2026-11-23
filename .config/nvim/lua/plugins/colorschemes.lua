return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
      transparent = true,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
    end,
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      terminal_colors = false,
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts)
    end,
  },
}
