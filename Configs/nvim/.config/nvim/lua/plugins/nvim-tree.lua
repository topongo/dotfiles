return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    -- surpassed by oil.nvim
    -- { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
  },
  lazy = false,
  config = function()
    require("nvim-tree").setup()
  end,
}

