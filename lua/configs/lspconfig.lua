-- load defaults i.e lua_lsp
--require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
   }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- Luau lsp (Roblox)
---@alias luau-lsp.PlatformType "standard" | "roblox"
---@alias luau-lsp.RobloxSecurityLevel "None" | "LocalUserSecurity" | "PluginSecurity" | "RobloxScriptSecurity"

---@class luau-lsp.Config
local defaults = {
   platform = {
      ---@type luau-lsp.PlatformType
      type = "roblox",
   },
   sourcemap = {
      enabled = true,
      autogenerate = true,
      rojo_path = "rojo",
      rojo_project_file = "default.project.json",
      include_non_scripts = true,
      sourcemap_file = "sourcemap.json",
   },
   types = {
      ---@type string[]
      definition_files = {},
      ---@type string[]
      documentation_files = {},
      ---@type luau-lsp.RobloxSecurityLevel
      roblox_security_level = "PluginSecurity",
   },
   fflags = {
      enable_by_default = false,
      sync = true,
      ---@type table<string, string>
      override = {},
   },
   plugin = {
      enabled = false,
      port = 3667,
   },
   ---@class luau-lsp.ClientConfig: vim.lsp.ClientConfig
   server = {
      ---@type string[]
      cmd = { "luau-lsp", "lsp" },
      ---@type fun(path: string): string?
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

local function rojo_project()
   return vim.fs.root(0, function(name)
      return name:match ".+%.project%.json$"
   end)
end

if rojo_project() then
   vim.filetype.add {
      extension = {
         lua = function(path)
            return path:match "%.nvim%.lua$" and "lua" or "luau"
         end,
      },
   }
end

require("luau-lsp").setup(defaults)
