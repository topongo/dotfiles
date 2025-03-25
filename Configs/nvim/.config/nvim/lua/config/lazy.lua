-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.number = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup colorscheme for bufferline
vim.opt.termguicolors = true

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

-- Setup lazy.nvim
require("lazy").setup(
  {
    { import = "plugins" },
  },
  {
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "yoru" } },
    -- automatically check for plugin updates
    checker = { 
      enabled = true, 
      notify = true,
    },
    change_detection = {
      notify = true,
    }
  }
)
