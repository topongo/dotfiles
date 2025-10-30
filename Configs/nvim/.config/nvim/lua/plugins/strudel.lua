return {
  "gruvw/strudel.nvim",
  build = "npm install",
  lazy = false,
  keys = {
    {
      "<leader>sl",
      "<Cmd>StrudelLaunch<CR>",
      mode = "n",
      desc = "Launch Strudel",
    },
    {
      "<C-CR>",
      "<Cmd>StrudelUpdate<CR>",
      mode = { "n", "i" },
      desc = "Update strudel"
    },
    {
      "<C-.>",
      "<Cmd>StrudelToggle<CR>",
      mode = { "n", "i" },
      desc = "Toggle strudel playback",
    },
  },
  config = function()
    require("strudel").setup({
    ui = {
      hide_top_bar = true,
    },
    update_on_save = true,
    browser_exec_path = ".config/nvim/scripts/open_strudel.sh",
  })
  end,
}
