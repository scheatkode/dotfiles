return {
	setup = function()
		local actions   = require('lir.actions')
		local clipboard = require('lir.clipboard.actions')
		local marks     = require('lir.mark.actions')

		local lir = require('lir')

		local function newfile()
			local function with_directory(path, action)
				local curdir = vim.fn.getcwd()

				vim.cmd(string.format(':lcd %s', path))
				action()
				vim.cmd(string.format(':lcd %s', curdir))
			end

			local context = lir.get_context()
			local lirdir  = context.dir
			local name

			with_directory(
				lirdir,
				function()
					name = vim.fn.input('New file: ', '', 'file')
				end
			)

			if name == '' then
				return
			end

			if name == '.' or name == '..' then
				print('Invalid file name: ', name)
			end

			local path = require('plenary.path'):new(lirdir .. name)

			if string.match(name, '/$') then
				name = name:gsub('/$', '')
				path:mkdir({ parents = true, exists_ok = false })
			else
				path:touch({ parents = true })
			end

			-- if the first character is '.' and `show_hidden_files` is
			-- false, set it to true.
			if name:match('^%.') and not lir.config.values.show_hidden_files then
				lir.config.values.show_hidden_files = true
			end

			actions.reload()

			-- jump to a line in the parent directory of the created file.
			local l = context:indexof(name:match('^[^/]+'))
			if l then
				vim.cmd(tostring(l))
			end
		end

		lir.setup({
			ignore = {},

			show_hidden_files = false,

			mappings = {
				['<CR>']  = actions.edit,
				['o']     = actions.edit,
				['<C-s>'] = actions.split,
				['<C-v>'] = actions.vsplit,

				['-'] = actions.up,

				['q']     = actions.quit,
				['<Esc>'] = actions.quit,
				['<C-c>'] = actions.quit,

				['R'] = actions.reload,

				['A'] = actions.mkdir,
				['r'] = actions.rename,
				['@'] = actions.cd,
				['X'] = actions.delete,

				['a'] = newfile,

				['Y'] = actions.yank_path,
				['H'] = actions.toggle_show_hidden,

				['<Tab>'] = marks.toggle_mark,

				['yy'] = clipboard.copy,
				['dd'] = clipboard.cut,
				['p']  = clipboard.paste,

				['.'] = function()
					local context = lir.get_context()
					local command = ':<C-u> ' .. context:current_value() .. '<Home>'
					local keys    = vim.api.nvim_replace_termcodes(command, true, true, true)

					vim.api.nvim_feedkeys(keys, 'nt', false)
				end,
			},

			float = {
				winblend = 0,

				win_opts = function()
					return {
						border = 'none',
					}
				end,

				curdir_window = {
					enable            = true,
					highlight_dirname = true,
				}
			},
		})
	end
}
