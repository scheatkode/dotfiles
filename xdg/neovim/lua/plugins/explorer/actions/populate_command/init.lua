return function()
	local context = require('lir').get_context()
	local command = ':<C-u> ' .. context:current_value() .. '<Home>'
	local keys    = vim.api.nvim_replace_termcodes(command, true, true, true)

	vim.api.nvim_feedkeys(keys, 'nt', false)
end
