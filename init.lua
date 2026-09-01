    ----------------------------
    --- Core Neovim settings ---
    ----------------------------
    vim.loader.enable()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    vim.g.have_nerd_font = true

    vim.o.number = true
    vim.o.mouse = 'a'
    vim.o.showmode = false
    vim.o.breakindent = true
    vim.o.undofile = true

    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.o.signcolumn = 'yes'
    vim.o.updatetime = 250

    vim.o.timeoutlen = 300
    vim.o.splitright = true
    vim.o.splitbelow = true
    vim.o.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    vim.o.inccommand = 'split'
    vim.o.cursorline = true
    vim.o.scrolloff = 15

    vim.o.confirm = true

    -- Tab settings (holy)
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.smarttab = false
    vim.o.tabstop = 4
    vim.o.expandtab = false

    vim.opt.clipboard = "unnamedplus"
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    ---------------
    --- Keymaps ---
    ---------------
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

    -- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
    vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
    vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
    vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
    vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
    vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
    vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
    vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
    vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')
    --------------------
    --- Autocommands ---
    --------------------
    -- Highlight when yanking (copying) text.
    vim.api.nvim_create_autocmd('TextYankPost',
    {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
	vim.hl.on_yank()
	end,
    })
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = { "html", "shtml", "htm" },
		callback = function()
			vim.lsp.start({
				name = "superhtml",
				cmd = { "superhtml", "lsp" },
				root_dir = vim.fs.dirname(vim.fs.find({".git"}, { upward = true })[1])
			})
  		end
	})
    ---------------
    --- Plugins ---
    ---------------
	local plugins = {
	  { src = 'https://github.com/neovim/nvim-lspconfig' },
	  { src = 'https://github.com/ibhagwan/fzf-lua' },
	  { src = 'https://github.com/mason-org/mason.nvim'},
	  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
	  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	  { src = 'https://github.com/Saghen/blink.cmp' },
	  { src = 'https://github.com/L3MON4D3/LuaSnip' },
	  { src = 'https://github.com/rafamadriz/friendly-snippets' },
	  { src = 'https://github.com/nvim-lua/plenary.nvim' },
	  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
	  { src = 'https://github.com/folke/which-key.nvim' },
	  { src = 'https://github.com/stevearc/conform.nvim' },
	  { src = 'https://github.com/mfussenegger/nvim-lint' },
	  { src = 'https://github.com/RRethy/base16-nvim' },
}
	vim.pack.add(plugins)

	--Setup
	require("mason").setup()
	require("lualine").setup()
	vim.lsp.enable('lua_ls')
	require("nvim-treesitter").setup()
	require("nvim-treesitter").install({
	  'html', 'css', 'lua', 'javascript',
	})
    local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config('cssls', {
	  capabilities = capabilities,
    })
	vim.lsp.enable('cssls')
	vim.lsp.enable('csharp_ls')

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
	  completion = {
		callSnippet = "Replace",
	  },
    },
  },
})
require("blink.cmp").setup()
require("matugen").setup()
local lualine_config = {
  options = {
    theme = 'base16',
  },
}
require('lualine').setup(lualine_config)
local signal = vim.uv.new_signal()

signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()

    require('lualine').setup(lualine_config)
  end)
)
vim.lsp.enable('biome')
vim.lsp.enable('vtsls')
