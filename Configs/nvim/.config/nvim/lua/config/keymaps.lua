-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

function find_or_add_checkbox()
  local line = vim.api.nvim_get_current_line()
  local start = line:find("%- %[.%]")
  if start == nil then
    -- no checkbox found, add it
    vim.api.nvim_feedkeys("^wi- [ ]", 'n', false)
    start = line:find("%- %[.%]")
  end
  local c = line:sub(start + 3, start + 3)
  return start, c == "x"
end


local map = vim.api.nvim_set_keymap

map("n", "<Up>", "<Nop>", { noremap = true, silent = true })
map("n", "<Down>", "<Nop>", { noremap = true, silent = true })
map("n", "<Left>", "<Nop>", { noremap = true, silent = true })
map("n", "<Right>", "<Nop>", { noremap = true, silent = true })
map("i", "<Up>", "<Nop>", { noremap = true, silent = true })
map("i", "<Down>", "<Nop>", { noremap = true, silent = true })
map("i", "<Left>", "<Nop>", { noremap = true, silent = true })
map("i", "<Right>", "<Nop>", { noremap = true, silent = true })
map("v", "<Up>", "<Nop>", { noremap = true, silent = true })
map("v", "<Down>", "<Nop>", { noremap = true, silent = true })
map("v", "<Left>", "<Nop>", { noremap = true, silent = true })
map("v", "<Right>", "<Nop>", { noremap = true, silent = true })

map("n", "<leader>Ll", "<cmd>Lazy<cr>", { noremap = true, silent = true })
map("n", "<leader>Lu", "<cmd>Lazy update<cr>", { noremap = true, silent = true })

map("i", "jk", "<esc>", { noremap = true, silent = true, desc = "jk to escape" })

map("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true, desc = "Close current buffer" })
map("n", "<leader>be", "<cmd>enew<cr>", { noremap = true, silent = true, desc = "New empty buffer" })
map("n", "<leader>cc", "", {noremap = true, silent = true, desc = "Toggle checkbox, add it if not present", callback = function()
  -- add checkbox if not present
  local start, checked = find_or_add_checkbox()

  -- set character at start + 3 of the line to x if not checked, or to space if checked
  local new_char = checked and " " or "x"
  -- goto start + 3
  vim.api.nvim_feedkeys((start + 3) .. "|", 'n', false)
  -- vim.api.nvim_win_set_cursor(0, { nil, start + 3 })
  -- set the character
  vim.api.nvim_feedkeys("r" .. new_char, 'n', false)
end})
