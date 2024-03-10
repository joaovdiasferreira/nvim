local lspconfig = require('lspconfig')


require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup()

lspconfig.lua_ls.setup{
	settings = {
		Lua = {
			diagnostics = { globals	= {'vim'}}
		}
	}
}

lspconfig.clangd.setup{}
lspconfig.pyright.setup{}
