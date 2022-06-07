---Return the given parameter without modification.
---
---This is a function that always returns the value that was
---used as its argument, unchanged. That is, when `f` is the
---identity function, the equality `f(x) = x` is true for all
---values of `x` to which `f` can be applied. In mathematical
---notation:
---
---```
---f: ∀ x ∈ X; x ↦ x
---```
---
---```lua
---local identity = require('f.function.identity')
---
---assert.are.same(420, identity(420))
---```
---
---@generic A
---
---@vararg any
---@return ...
local function identity(...) return ... end

return identity
