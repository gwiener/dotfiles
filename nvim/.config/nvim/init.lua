-- Neovim configuration
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
  
-- Plugin setup
require("lazy").setup("plugins")

-- Enable absolute line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Highlight the current line
vim.opt.cursorline = true
-- Keep 10 lines visible above and below the cursor when scrolling
vim.opt.scrolloff = 10
vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.keymap.set('n', '<M-/>', ':nohlsearch<CR>')

