local function setup()
	local has_packer, packer = pcall(require, 'packer')
	local has_util,   util   = pcall(require, 'packer.util')

	if not has_packer or not has_util then
		error('Expected packer to be installed')
	end

	return packer.init({
		package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
		compile_path = util.join_paths(vim.fn.stdpath('data'), 'site', 'plugin', 'compiled.lua'),

		ensure_dependencies = true, -- should packer install plugin dependencies?

		plugin_package = 'packer', -- the default package for plugins
		max_jobs       = 8,        -- limit the number of simultaneous jobs. nil means no limit

		auto_clean           = true, -- during sync(), remove unused plugins
		auto_reload_compiled = true, -- automatically reload the compiled file after creating it.
		compile_on_sync      = true, -- during sync(), run packer.compile()

		disable_commands   = false, -- disable creating commands
		opt_default        = false, -- default to using opt (as opposed to start) plugins
		transitive_opt     = true,  -- make dependencies of opt plugins also opt by default
		transitive_disable = true,  -- automatically disable dependencies of disabled plugins

		git = {
			cmd           = 'git', -- the base command for git operations
			clone_timeout = 600,   -- timeout, in seconds, for git clones
			depth         = 1,     -- git clone depth

			subcommands = { -- format strings for git subcommands
				update         = 'pull --ff-only --progress --rebase=false',
				install        = 'clone --depth %i --no-single-branch --progress',
				fetch          = 'fetch --depth 999999 --progress',
				checkout       = 'checkout %s --',
				update_branch  = 'merge --ff-only @{u}',
				current_branch = 'branch --show-current',
				diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
				diff_fmt       = '%%h %%s (%%cr)',
				get_rev        = 'rev-parse --short HEAD',
				get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
				submodules     = 'submodule update --init --recursive --progress'
			},
		},

		display = {
			compact         = true,            -- If true, fold updates results by default
			non_interactive = false,           -- if true, disable display windows for all operations
			open_fn         = nil,             -- an optional function to open a window for packer's display
			open_cmd        = '60vnew packer', -- an optional command to open a window for packer's display
			working_sym     = '⟳',             -- the symbol for a plugin being installed/updated
			error_sym       = '✗',             -- the symbol for a plugin with an error in installation/updating
			done_sym        = '✓',             -- the symbol for a plugin which has completed installation/updating
			removed_sym     = '-',             -- the symbol for an unused plugin which was removed
			moved_sym       = '→',             -- the symbol for a plugin which was moved (e.g. from opt to start)
			header_sym      = '━',             -- the symbol for the header line in packer's display
			show_all_info   = true,            -- should packer show all update details automatically?
		},

		luarocks = {
			python_cmd = 'python' -- set the python command to use for running hererocks
		},

		profile = {
			enable    = false,
			threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
		}
	})
end

return {
	setup = setup
}
