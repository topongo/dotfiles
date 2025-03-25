return {
  "smoka7/hop.nvim",
  lazy = false,
  tag = "v2.7.1",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  keys = {
    { "<leader>hh", "<cmd>HopWordMW<cr>", desc = "Hop to word" },
    { "<leader>hcc", "<cmd>HopChar1MW<cr>", desc = "Hop to char" },
    { "<leader>hcv", "<cmd>HopChar2MW<cr>", desc = "Hop to pair of chars" }, 
  }
-- config = function()
--     require("hop").setup()
--     local wk = require("which-key")
--     wk.add({
--       { "<leader>hh", "<cmd>HopWordMW<cr>", desc = "Hop to word" },
--       { "<leader>hcc", "<cmd>HopChar1MW<cr>", desc = "Hop to char" },
--       { "<leader>hcv", "<cmd>HopChar2MW<cr>", desc = "Hop to pair of chars" }, 
--     })
--   end
}
