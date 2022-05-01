--- perform  left-to-right  function  composition.   the   first
--- argument may have - any arity, the remaining arguments  must
--- be unary. This effectively creates a function that takes the
--- arguments of the first function and gives the  return  value
--- of the last function, applying every function in between.
---
--- @see pipe
---
--- ```lua
--- local compose = require('f.function.compose')
---
--- local length = function(s: string): number return #s    end
--- local double = function(n: number): number return n * 2 end
---
--- local f = compose(length, double)
---
--- assert.same(6, f('foo'))
--- ```
---
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R, fun(r: R): S, fun(s: S): T): T
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R, fun(r: R): S): S
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q, fun(q: Q): R): R
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P, fun(p: P): Q): Q
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O, fun(o: O): P): P
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N, fun(n: N): O): O
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M, fun(m: M): N): N
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L, fun(l: L): M): M
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K, fun(k: K): L): L
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J, fun(j: J): K): K
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I, fun(i: I): J): J
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H, fun(h: H): I): I
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G, fun(g: G): H): H
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F, fun(f: F): G): G
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E, fun(e: E): F): F
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(d: D): E): E
--- @overload fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D): D
--- @overload fun(ab: fun(...: any): B, fun(b: B): C): C
--- @overload fun(ab: fun(...: any): B): B
local function compose (...)

   -- unrolling the first 20 iterations of the loop  for  better
   -- performance; it's extremely rare that  anyone  would  need
   -- anything more. it is also split in two to keep the  lookup
   -- time minimal for the latter part.

   local count = select('#', ...)
   local funcs = { ... }

   assert(count > 0, 'expected at least one function as argument to `compose`')

   if count < 11 then
      if count == 1 then return function (...) return funcs[1](...) end end
      if count == 2 then return function (...) return funcs[2](funcs[1](...)) end end
      if count == 3 then return function (...) return funcs[3](funcs[2](funcs[1](...))) end end
      if count == 4 then return function (...) return funcs[4](funcs[3](funcs[2](funcs[1](...)))) end end
      if count == 5 then return function (...) return funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))) end end
      if count == 6 then return function (...) return funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))) end end
      if count == 7 then return function (...) return funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))) end end
      if count == 8 then return function (...) return funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))) end end
      if count == 9 then return function (...) return funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))) end end

      return function (...) return funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))) end
   end

   if count < 21 then
      if count == 10 then return function (...) return funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))) end end
      if count == 11 then return function (...) return funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))))) end end
      if count == 12 then return function (...) return funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))))) end end
      if count == 13 then return function (...) return funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))))))) end end
      if count == 14 then return function (...) return funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))))))) end end
      if count == 15 then return function (...) return funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))))))))) end end
      if count == 16 then return function (...) return funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))))))))) end end
      if count == 17 then return function (...) return funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))))))))))) end end
      if count == 18 then return function (...) return funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))))))))))) end end
      if count == 19 then return function (...) return funcs[19](funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...))))))))))))))))))) end end

      return function (...) return funcs[20](funcs[19](funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](...)))))))))))))))))))) end
   end

   return function (...)
      local result = funcs[1](...)

      for i = 2, count do
         result = funcs[i](result)
      end

      return result
   end
end

return compose
