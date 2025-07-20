-- lsps with default config
local servers = { "lua_ls", "luau_lsp" }

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = servers
})

local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach
	}
end

local IS_ROBLOX_PROJECT = require("configs.roblox-lsp")
if IS_ROBLOX_PROJECT then
	return
end

local LSPConfig = require("lspconfig")

-- Lua lsp (vim)
LSPConfig.lua_ls.setup({
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {}
	}
})
