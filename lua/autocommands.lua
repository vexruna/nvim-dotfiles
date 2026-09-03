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
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
		})
	end
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
