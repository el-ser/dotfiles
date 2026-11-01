return {
  "akinsho/bufferline.nvim",
  enabled = false,
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
      return
    end
    vim.opt.termguicolors = true
    bufferline.setup({
      highlights = {
        fill = {
          bg = "none",
        },
        background = {
          bg = "none",
        },
        tab = {
          bg = "none",
        },
        tab_selected = {
          bg = "none",
        },
        tab_close = {
          bg = "none",
        },
        close_button = {
          bg = "none",
        },
        close_button_visible = {
          bg = "none",
        },
        close_button_selected = {
          bg = "none",
        },
        buffer_selected = {
          bg = "none",
          bold = true,
          italic = false,
        },
        buffer_visible = {
          bg = "none",
        },
        buffer = {
          bg = "none",
        },
        separator = {
          bg = "none",
        },
        separator_selected = {
          bg = "none",
        },
        separator_visible = {
          bg = "none",
        },
        modified = {
          bg = "none",
        },
        modified_selected = {
          bg = "none",
        },
        modified_visible = {
          bg = "none",
        },
      },
    })
  end,
}
