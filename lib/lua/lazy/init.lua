---A set of helper functions to make lazy loading modules easier.
---
---Original: https://github.com/tjdevries/lazy.nvim
---
return {
	on_index       = require('lazy.on_index'),
	on_module_call = require('lazy.on_module_call'),
	on_member_call = require('lazy.on_member_call'),
}
