return {
	---Setup grepping behaviour.
	setup = function()
		local pipe     = require('f.function.pipe')
		local rpartial = require('f.function.rpartial')

		if vim.fn.executable('rg') == 1 then
			vim.opt.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
			vim.opt.grepformat:prepend({ '%f:%l:%c:%m' })
		elseif vim.fn.executable('ag') == 1 then
			vim.opt.grepprg = [[ag --nogroup --nocolor --vimgrep]]
			vim.opt.grepformat:prepend({ '%f:%l:%c:%m' })
		end

		vim.opt.wildcharm = pipe(
			'<Tab>',
			rpartial(vim.api.nvim_replace_termcodes, true, true, true),
			vim.fn.char2nr
		)

		vim.opt.wildmode       = 'longest:full,full' -- Show a menu bar as opposed to an enormous list
		vim.opt.wildignorecase = true -- Ignore case when completing file and directory names
		vim.opt.wildoptions    = 'pum'

		vim.opt.wildignore = { -- Mostly binaries and the dreaded `node_modules`
			'*.*~', '*.aux', '*.avi', '*.class', '*.dll', '*.gif',
			'*.ico', '*.jar', '*.jpeg', '*.jpg', '*.o', '*.obj',
			'*.out', '*.png', '*.pyc', '*.rbc', '*.swp', '*.toc',
			'*.wav', '*pycache*', '*~ ', '*~', '.DS_Store', 'Thumbs.db',
			'.lock', 'tags.lock'
		}

		vim.opt.completeopt = {
			'menu', -- Use the pop-up menu for completion
			'menuone', -- Use the pop-up menu also when there is only one match
			'preview', -- Show extra information about the currently selected item
			-- 'longest',  -- Only insert the longest common match
			'noinsert', -- Do not insert any text for a match
			'noselect', -- Do not autoselect a match
		}

	end
}
