--require "nvchad.mappings"

vim.cmd("set relativenumber")
vim.cmd("set number")
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

-- telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })

-- Harpoor mappings
local Harpoon = require("harpoon")
Harpoon:setup()

vim.keymap.set("n", "<leader>h", function() Harpoon.ui:toggle_quick_menu(Harpoon:list()) end, KeymapInfo)
vim.keymap.set("n", "<leader>a", function() Harpoon:list():add() end)

for Index = 1,7 do
	vim.keymap.set("n", "<leader>".. Index, function() Harpoon:list():select(Index) end)
end

vim.keymap.set("n", "<leader>p", function() Harpoon:list():prev() end, KeymapInfo)
vim.keymap.set("n", "<leader>n", function() Harpoon:list():next() end, KeymapInfo)

-- Oil mappings
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Auto-complete mappings
local AutoComplete = require "cmp"
local ls = require("luasnip")

--[[local function Select()
	if not ls.choice_active() then
		return
	end

	ls.change_choice(1)
end]]

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
	mapping = AutoComplete.mapping.preset.insert({
		--[[["<C-k>"] = AutoComplete.mapping.complete(),
		["<C-l>"] = AutoComplete.mapping(function(fallback)
			if AutoComplete.visible() then
				AutoComplete.select_next_item()
			elseif snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif has_words_before() then
				AutoComplete.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-j>"] = AutoComplete.mapping(function(fallback)
			if AutoComplete.visible() then
				AutoComplete.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" })]]
	}),
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

-- Spotify integrantion
local spotify = require'nvim-spotify'

spotify.setup {
	-- default opts
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
