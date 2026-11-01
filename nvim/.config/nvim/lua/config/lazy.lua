local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.vim-options")
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "solarized-osaka" },
  },
  change_detections = {
    enabled = true,
    notify = false,
  },
  rocks = {
    enabled = false,
  },
})
require("config.keymaps")

-- set as colorscheme
-- vim.cmd.colorscheme("tokyodark")
-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("solarized-osaka")
