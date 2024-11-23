require "nvchad.mappings"

vim.cmd("set relativenumber")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")

--vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>")

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, { desc = 'Find Files' })

--vim.keymap.set('n', '<C-S-t>', ':Telescope projects<CR>', { desc = 'Find Projects' })
