return {
	-- LSP
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0",
	},

	{ "hrsh7th/nvim-cmp" },

	{ "hrsh7th/cmp-nvim-lsp" },

	{ "neovim/nvim-lspconfig" },

	{
		"lopi-py/luau-lsp.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Usage
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require "configs.dashboard"
		end,
		dependencies = { {'nvim-tree/nvim-web-devicons'}}
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	{ "matze/vim-move" },

	{ "sitiom/nvim-numbertoggle" },

	{ "folke/twilight.nvim" },

	{ "L3MON4D3/LuaSnip"	},

	{
		'KadoBOT/nvim-spotify',
		dependencies = { "nvim-telescope/telescope.nvim" }
	},

	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{ "andweeb/presence.nvim" },

	{ 'soycarlo99/nvim-boolean-toggle' },

	--[[{
		"stevearc/conform.nvim",
	},]]

	{ "Catppuccin/nvim" },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim", "lua", "vimdoc",
				"html", "css", "rust",
				"javascript"
			},
		},
	},

	-- Rust config
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		'rcarriga/nvim-dap-ui',
		dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
		config = function()
			require("dapui").setup()
		end,
	},
}
