return {
  "smoka7/hop.nvim",
  lazy = false,
  tag = "v2.7.1",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  keys = function()
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    local keys = {
      { "<leader>hh", "<cmd>HopWordMW<cr>", desc = "Hop to word" },
      { "<leader>hcc", "<cmd>HopChar1MW<cr>", desc = "Hop to char" },
      { "<leader>hcv", "<cmd>HopChar2MW<cr>", desc = "Hop to pair of chars" },
      { "dH", "<cmd>HopLineMW<cr>"},
    }

    for k, v in pairs({
      F = { drection = directions.BEFORE_CURSOR, current_line_only = true },
      f = { direction = directions.AFTER_CURSOR, current_line_only = true },
      T = { direction = directions.NEAREST_UP, current_line_only = true, hint_offset = 1 },
      t = { direction = directions.NEAREST_DOWN, current_line_only = true, hint_offset = -1 },
    }) do
      table.insert(keys, {
        k,
        function()
          hop.hint_char1({ direction = v, current_line_only = true })
        end,
        remap = true,
        mode = '',
      })
    end
    return keys
  end,
}
