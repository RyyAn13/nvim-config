--require "nvchad.mappings"

vim.cmd("set relativenumber")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")

local KeymapInfo = { noremap = true, silent = true }

vim.keymap.set("i", "jk", "<ESC>", KeymapInfo)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', KeymapInfo)

vim.keymap.set('n', '<C-h>', '<C-w>h', KeymapInfo)
vim.keymap.set('n', '<C-j>', '<C-w>j', KeymapInfo)
vim.keymap.set('n', '<C-k>', '<C-w>k', KeymapInfo)
vim.keymap.set('n', '<C-l>', '<C-w>l', KeymapInfo)

vim.keymap.set('n', '[', '^', KeymapInfo)

-- Disable highlighting of visual mode selection hints
vim.opt.visualbell = false

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, { desc = 'Find Files' })
