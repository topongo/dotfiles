return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      "size",
    }
  },
  view_options = {
    show_hidden = true,
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {"<C-n>", "<cmd>Oil<cr>", { noremap = true, silent = true }},
    {"<C-S-n>", "<cmd>Oil --float<cr>", { noremap = true, silent = true }},
  }
}
