-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

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
