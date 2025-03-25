return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  priority = 100,
  -- opts = {
  --   spec = {
  --     { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree", mode = "n" },
  --   },
  -- },
  keys = {
    {
      "<leader>?",
      function()
	      require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
