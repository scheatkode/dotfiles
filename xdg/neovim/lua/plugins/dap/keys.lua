local dap    = require('dap')
-- local dapvar = require('dap.ui.variables')
-- local dapwid = require('dap.ui.widgets')

local function setup ()
	vim.keymap.set('n', '<leader>dc', {desc = 'Continue'})
	vim.keymap.set('n', '<leader>dC', {desc = 'Run to cursor'})
	vim.keymap.set('n', '<leader>db', {desc = 'Toggle breakpoint'})
	vim.keymap.set('n', '<leader>di', {desc = 'Step into'})
	vim.keymap.set('n', '<leader>do', {desc = 'Step over'})
	vim.keymap.set('n', '<leader>dO', {desc = 'Step out'})
	vim.keymap.set('n', '<leader>dp', {desc = 'Step back'})
	vim.keymap.set('n', '<leader>dP', {desc = 'Pause'})
	vim.keymap.set('n', '<leader>dr', {desc = 'Toggle REPL'})
	vim.keymap.set('n', '<leader>dR', {desc = 'Run last'})
	vim.keymap.set('n', '<leader>dQ', {desc = 'Close session'})
	vim.keymap.set('n', '<leader>dD', {desc = 'Disconnect from session'})
	vim.keymap.set('n', '<leader>dq', {desc = 'Send breakpoints to quicklist'})
	vim.keymap.set('n', '<leader>du', {desc = 'Go up in stacktrace'})
	vim.keymap.set('n', '<leader>dd', {desc = 'Go down in stacktrace'})
	vim.keymap.set('n', '<leader>dk', {desc = 'Hover'})
	vim.keymap.set('n', '<leader>dK', {desc = 'Hover'})

	vim.keymap.set('n', '<leader>dB', function () dap.set_breakpoint(vim.fn.input('Breakpoint condition : ')) end, {desc = 'Set breakpoint with condition'})
	vim.keymap.set('n', '<leader>dl', function () dap.set_breakpoint(nil, nil, vim.fn.input('Log point message : ')) end, {desc = 'Set log point'})
end

return {
	setup = setup
}
