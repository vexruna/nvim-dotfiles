---------------
--- Plugins ---
---------------
local i = "https://github.com/"
local plugins = {
	{ src = i .. "andweeb/presence.nvim" }, -- Discord Rich Presence support
	{ src = i .. "nvim-treesitter/nvim-treesitter" }, --Turns your code into a tree structure
	{ src = i .. "neovim/nvim-lspconfig" }, -- Provides default configuration files for LSP
	{ src = i .. "mason-org/mason.nvim" }, -- Package Manager for LSP
	{ src = i .. "nvim-lua/plenary.nvim" }, -- A library of lua functions; dependency for some plugins.
	{ src = i .. "nvim-telescope/telescope.nvim" }, -- Fuzzy picker
	{ src = i .. "nvim-tree/nvim-web-devicons" }, -- Nerd Font Icons
	{ src = i .. "nvim-lualine/lualine.nvim" }, -- Status Line
	{ src = i .. "Saghen/blink.cmp" }, -- Autocompletion plugin
	{ src = i .. "L3MON4D3/LuaSnip" }, -- Snippet Engine
	{ src = i .. "rafamadriz/friendly-snippets" }, --A set of preconfigured code snippets
	{ src = i .. "lewis6991/gitsigns.nvim" }, -- Git Signs, lets you see which lines were changed, added or deleted and etc.
	{ src = i .. "folke/which-key.nvim" }, -- Shows you your keymaps in a popup dialog
	{ src = i .. "stevearc/conform.nvim" }, --Formatter config
	{ src = i .. "mfussenegger/nvim-lint" }, -- Linter
	{ src = i .. "RRethy/base16-nvim" }, --Colorscheme package used by matugen which is used by Noctalia
	{ src = i .. "MunifTanjim/nui.nvim" }, -- neo-tree dependency
	{ src = i .. "nvim-neo-tree/neo-tree.nvim" }, --File Management Tree
}
vim.pack.add(plugins)

--My config setup
require("plugins.cssls")
require("plugins.luals")
require("plugins.conform")
require("plugins.nvim-lint")
--Setup
require("presence").setup()
require("nvim-treesitter").setup()
require("nvim-treesitter").install({
	"html",
	"css",
	"lua",
	"javascript",
})
require("mason").setup()
require("lualine").setup()
vim.lsp.enable("lua_ls")
require("blink.cmp").setup()
vim.lsp.enable("biome")
vim.lsp.enable("csharp_ls")

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	},
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = true,
})

-- Sets the color scheme
require("matugen").setup()
local lualine_config = {
	options = {
		theme = "base16",
	},
}
require("lualine").setup(lualine_config)
local signal = vim.uv.new_signal()
-- Updates the colorscheme when it changes without restarting
signal:start(
	"sigusr1",
	vim.schedule_wrap(function()
		package.loaded["matugen"] = nil
		require("matugen").setup()
		require("lualine").setup(lualine_config)
	end)
)
