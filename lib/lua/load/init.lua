---A set of helper functions to make lazy loading modules easier.
---
---Original: https://github.com/tjdevries/lazy.nvim
---
return {
	on_index       = require('load.on_index'),
	on_module_call = require('load.on_module_call'),
	on_member_call = require('load.on_member_call'),
}
