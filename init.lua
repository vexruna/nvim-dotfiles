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
    vim.o.tabstop = 8
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
    vim.keymap.set({ 'n' }, '<Leader>e', '<cmd>NvimTreeToggle<CR>')
    vim.keymap.set('n', '<Leader>d', function() vim.diagnostic.open_float() end)

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

    -- Create a command `:GitBlameLine` that print the git blame for the current line
    vim.api.nvim_create_user_command('GitBlameLine', function()
	local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
	local filename = vim.api.nvim_buf_get_name(0)
	print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
    end, { desc = 'Print the git blame for the current line' })

    ---------------
    --- Plugins ---
    ---------------
    require("config.lazy")
    require('nvim-treesitter').setup {
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath('data') .. '/site'
	}
    require('nvim-treesitter').install { 'rust', 'javascript', 'vim', 'lua', 'c', 'cpp', 'c_sharp', 'html', 'css', 'markdown', 'markdown_inline', 'typescript'}
    require("nvim-tree").setup()
    require('lualine').setup()
