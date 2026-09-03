local M = {}

function M.setup()
	require('base16-colorscheme').setup({
		base00 = '#15141b',
		base01 = '#29263c',
		base02 = '#322e48',
		base03 = '#6d6d6d',
		base04 = '#edecee',
		base05 = '#edecee',
		base06 = '#edecee',
		base07 = '#edecee',
		base08 = '#ff6767',
		base09 = '#ffca85',
		base0A = '#61ffca',
		base0B = '#a277ff',
		base0C = '#ffc880',
		base0D = '#a880ff',
		base0E = '#80ffd4',
		base0F = '#b3ffe5',
	})

	local hi = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	hi('TelescopeNormal', { fg = '#edecee', bg = '#15141b' })
	hi('TelescopeBorder', { fg = '#6d6d6d', bg = '#15141b' })
	hi('TelescopePromptNormal', { fg = '#edecee', bg = '#15141b' })
	hi('TelescopePromptBorder', { fg = '#6d6d6d', bg = '#15141b' })
	hi('TelescopePromptPrefix', { fg = '#a277ff', bg = '#15141b' })
	hi('TelescopePromptCounter', { fg = '#edecee', bg = '#15141b' })
	hi('TelescopePromptTitle', { fg = '#15141b', bg = '#a277ff' })
	hi('TelescopePreviewTitle', { fg = '#15141b', bg = '#61ffca' })
	hi('TelescopeResultsTitle', { fg = '#15141b', bg = '#ffca85' })
	hi('TelescopeSelection', { fg = '#edecee', bg = '#322e48' })
	hi('TelescopeSelectionCaret', { fg = '#a277ff', bg = '#322e48' })
	hi('TelescopeMatching', { fg = '#a277ff', bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
	_G.__matugen_signal:stop()
	_G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
	'sigusr1',
	vim.schedule_wrap(function()
		package.loaded['matugen'] = nil
		require('matugen').setup()
	end)
)

return M
