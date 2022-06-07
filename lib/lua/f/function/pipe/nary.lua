local compose = require('f.function.compose')

---Pipe the value of an expression into a pipeline of functions,
---effectively calling every function on the return value of the
---previous one.
---
---This function is effectively represented in mathematical
---notation like so:
---
---```
---f: ∀ x ∈ X₀, g₀ ∈ [X₀→X₁], ..., gₙ ∈ [Xₙ₋₁→Xₙ]; x ↦ (g₀∘...∘gₙ)(x)
---
---```
---
---```lua
---local pipe = require('f.function.pipe')
---
---local length = function(s: string): number return #s    end
---local double = function(n: number): number return n * 2 end
---
----- Without pipe
---assert.are.same(6, double(length('foo')))
---
----- With pipe
---assert.are.same(6, pipe('foo', length, double)
--- ```
---
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R, fun(r: R): S, fun(s: S): T): T
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R, fun(r: R): S): S
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R): R
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q): Q
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P): P
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O): O
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N): N
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M): M
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L): L
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K): K
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J): J
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I): I
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H): H
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G): G
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F): F
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(d: D): E): E
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D): D
---@overload fun(a: A, ab: fun(a: A): B, fun(b: B): C): C
---@overload fun(a: A, ab: fun(a: A): B): B
local function pipe_nary(a, ...)
	return compose(...)(a)
end

return pipe_nary
