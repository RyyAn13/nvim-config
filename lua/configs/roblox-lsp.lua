local defaults = {
	platform = {
		type = "roblox"
	},
	sourcemap = {
		enabled = true,
		autogenerate = true,
		rojo_path = "rojo",
		rojo_project_file = "default.project.json",
		include_non_scripts = true,
		sourcemap_file = "sourcemap.json"
	},
	types = {
		definition_files = {},
		documentation_files = {},
		roblox_security_level = "PluginSecurity"
	},
	fflags = {
		enable_by_default = false,
		sync = true,
		override = {}
	},
	plugin = {
		enabled = false,
		port = 3667
	},
	server = {
		cmd = { "luau-lsp", "lsp" },
		root_dir = function(path)
			return vim.fs.root(path, function(name)
				return name:match ".+%.project%.json$"
			end) or vim.fs.root(path, {
			".git",
			".luaurc",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
		})
	end
}
}

local function is_rojo_project()
	return vim.fs.root(0, function(name)
		return name:match ".+%.project%.json$"
	end)
end

if is_rojo_project() then
	vim.filetype.add {
		extension = {
			lua = function(path)
				return path:match "%.nvim%.lua$" and "lua" or "luau"
			end,
		},
	}

	require("luau-lsp").setup(defaults)
	return true
end

return false
