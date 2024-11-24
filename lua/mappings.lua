--require "nvchad.mappings"

vim.cmd("set relativenumber")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")

-- Basic mappings
local KeymapInfo = { noremap = true, silent = true }

vim.keymap.set("i", "jk", "<ESC>", KeymapInfo)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', KeymapInfo)

vim.keymap.set('n', '<C-h>', '<C-w>h', KeymapInfo)
vim.keymap.set('n', '<C-j>', '<C-w>j', KeymapInfo)
vim.keymap.set('n', '<C-k>', '<C-w>k', KeymapInfo)
vim.keymap.set('n', '<C-l>', '<C-w>l', KeymapInfo)

vim.keymap.set('n', '[', '^', KeymapInfo)

-- telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, { desc = 'Find Files' })

-- Harpoor mappings
local Harpoon = require("harpoon")
Harpoon:setup()

vim.keymap.set("n", "<leader>h", function() Harpoon.ui:toggle_quick_menu(Harpoon:list()) end, KeymapInfo)
vim.keymap.set("n", "<leader>1", function() Harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() Harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() Harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() Harpoon:list():select(4) end)

--vim.keymap.set("n", "<C-p>", function() Harpoon:list():prev() end, KeymapInfo)
--vim.keymap.set("n", "<C-m>", function() Harpoon:list():next() end, KeymapInfo)
