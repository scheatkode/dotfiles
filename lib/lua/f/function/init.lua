local lazy = require('load.on_module_call')

return {
	compose    = lazy('f.function.compose'),
	constant   = lazy('f.function.constant'),
	curry      = lazy('f.function.curry'),
	flip       = lazy('f.function.flip'),
	identity   = lazy('f.function.identity'),
	memoize    = lazy('f.function.memoize'),
	negate     = lazy('f.function.negate'),
	noop       = lazy('f.function.noop'),
	nooped     = lazy('f.function.nooped'),
	partial    = lazy('f.function.partial'),
	pipe       = lazy('f.function.pipe'),
	predicates = lazy('f.function.predicates'),
	rpartial   = lazy('f.function.rpartial'),
	ternary    = lazy('f.function.ternary'),
	when       = lazy('f.function.when'),
}
