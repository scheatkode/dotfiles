--- return the given parameter without modifications.
---
--- ```lua
--- local identity = require('f.function.identity')
---
--- assert.same(420, identity(420))
--- ```
---
--- @generic A
---
--- @param a A
--- @return A
local function identity (a) return a end

return identity
