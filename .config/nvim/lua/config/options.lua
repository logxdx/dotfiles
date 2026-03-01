-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- basics
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative kine numbers
vim.opt.cursorline = true -- highlight current line

-- tabbing & indentation
vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab stop
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from previous line
vim.opt.grepprg = "rg --vimgrep" -- use ripgrep instead of grep
vim.opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- visual settings
vim.opt.termguicolors = true
vim.opt.showmatch = true
