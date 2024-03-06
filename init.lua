--main configurations of nvim

--install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--def mapleader as space
vim.g.mapleader = " "

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

--themes
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  },

--mason and LSP	
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

--DAP 
  {
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
  },


--treesitter
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},


--CMP
  {
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',
     'hrsh7th/cmp-cmdline',
     'hrsh7th/nvim-cmp',
  --snips
     'L3MON4D3/LuaSnip',
     'saadparwaiz1/cmp_luasnip',
     'rafamadriz/friendly-snippets',
},


})

--set theme
vim.cmd[[colorscheme tokyonight]]

require("core.plugins-config.mason")
require("core.plugins-config.cmp")
require("luasnip.loaders.from_vscode").lazy_load()
require("core.settings")
require("core.plugins-config.dap")
require("core.plugins-config.dapui")
