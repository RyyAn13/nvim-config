vim.cmd("set relativenumber")
vim.cmd("set number")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

-- Colors
require("catppuccin").setup({
	flavour = "mocha"
})
vim.cmd.colorscheme("catppuccin")

-- Lua line
require("lualine").setup({
	options = { theme = "catppuccin" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "diagnostics", "lsp_status", "progress" },
		lualine_y = { "filetype", "fileformat" },
		lualine_z = { "encoding" },
	}
})

-- Basic mappings
local KeymapInfo = { noremap = true, silent = true }

vim.keymap.set("i", "jk", "<ESC>", KeymapInfo)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', KeymapInfo)

vim.keymap.set('n', '<C-h>', '<C-w>h', KeymapInfo)
vim.keymap.set('n', '<C-j>', '<C-w>j', KeymapInfo)
vim.keymap.set('n', '<C-k>', '<C-w>k', KeymapInfo)
vim.keymap.set('n', '<C-l>', '<C-w>l', KeymapInfo)

-- telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })

-- Harpoor mappings
local Harpoon = require("harpoon")
Harpoon:setup()

vim.keymap.set("n", "<leader>h", function() Harpoon.ui:toggle_quick_menu(Harpoon:list()) end, KeymapInfo)
vim.keymap.set("n", "<leader>a", function() Harpoon:list():add() end)

vim.keymap.set("n", "<leader>p", function() Harpoon:list():prev() end, KeymapInfo)
vim.keymap.set("n", "<leader>n", function() Harpoon:list():next() end, KeymapInfo)

for Index = 1,7 do
	vim.keymap.set("n", "<leader>".. Index, function() Harpoon:list():select(Index) end)
end

-- Oil mappings
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<leader>o', function()
	require("oil").toggle_hidden()
end, { desc = "Toggle hidden files" })

-- Auto-complete mappings
local AutoComplete = require "cmp"
AutoComplete.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = AutoComplete.config.window.bordered(),
		documentation = AutoComplete.config.window.bordered(),
	},
	mapping = AutoComplete.mapping.preset.insert({}),
	sources = AutoComplete.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }
	},
	{
		{ name = 'buffer' },
	})
})

require("luasnip.loaders.from_vscode").lazy_load()

-- Terminal
require("configs.terminal")

-- Discord presence
require("configs.discord-presence")

-- Use a different key for toggling
local BooleanToggle = require('nvim-boolean-toggle')
vim.keymap.set('n', '<leader>w', BooleanToggle.toggle_boolean_or_increment, { desc = 'Toggle boolean or increment' })

-- Twilight
vim.keymap.set("n", "<Leader>t", "<cmd>Twilight<CR>", { desc = "Toggle focus mode" })

-- Buscuits
require "configs.biscuits"

-- Spotify integrantion
local spotify = require'nvim-spotify'
spotify.setup {
	status = {
		update_interval = 10000, -- the interval (ms) to check for what's currently playing
		format = '%s %t by %a' -- spotify-tui --format argument
	}
}

vim.keymap.set("n", "<leader>so", ":Spotify<CR>", KeymapInfo) -- Open Spotify Search window
vim.keymap.set("n", "<leader>sd", ":SpotifyDevices<CR>", KeymapInfo) -- Open Spotify Devices window
vim.keymap.set("n", "<leader>sn", "<Plug>(SpotifySkip)", KeymapInfo) -- Skip the current track
vim.keymap.set("n", "<leader>sp", "<Plug>(SpotifyPause)", KeymapInfo) -- Pause/Resume the current track
vim.keymap.set("n", "<leader>ss", "<Plug>(SpotifySave)", KeymapInfo) -- Add the current track to your library
vim.keymap.set("n", "<leader>sb", "<Plug>(SpotifyPrev)", KeymapInfo) -- Go back to the previous track
vim.keymap.set("n", "<leader>sh", "<Plug>(SpotifyShuffle)", KeymapInfo) -- Toggles shuffle mode

-- nvim dap
vim.keymap.set("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
vim.keymap.set("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
vim.keymap.set("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
vim.keymap.set("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
vim.keymap.set("n", "<Leader>dd", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint" })
vim.keymap.set("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
vim.keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- C/C++
vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:!gcc % -o %:r && %:r.exe<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:!g++ % -o %:r && %:r.exe<CR>', { noremap = true, silent = true })

-- Init lsp
require "configs.lspconfig"
