return {
  "pocco81/auto-save.nvim",
  keys = {
    { "<leader>us", "<cmd>ASToggle<cr>", desc = "Toggle AutoSave" },
  },
  config = {
    enabled = false,
    execution_message = {
      message = "AutoCulo: saved at " .. vim.fn.strftime("%H:%M:%S"),
    },
    debounce_delay = 1000,
  }
}
