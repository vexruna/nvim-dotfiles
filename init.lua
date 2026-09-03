----------------------------
--- Core Neovim settings ---
----------------------------
vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250

vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 15

vim.o.confirm = true

-- Tab settings (holy)
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = false
vim.o.tabstop = 4
vim.o.expandtab = false

vim.opt.clipboard = "unnamedplus"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("autocommands")
require("keymaps")
require("plugins")
