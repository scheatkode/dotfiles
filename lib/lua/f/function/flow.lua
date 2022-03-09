--- perform  left-to-right  function  composition.   the   first
--- argument may have - any arity, the remaining arguments  must
--- be unary. This effectively creates a function that takes the
--- arguments of the first function and gives the  return  value
--- of the last function, applying every function in between.
---
--- @see pipe
---
--- ```lua
--- local flow = require('f.function.flow')
---
--- local length = function(s: string): number return #s    end
--- local double = function(n: number): number return n * 2 end
---
--- local f = flow(length, double)
---
--- assert.same(6, f('foo'))
--- ```
---
--- @generic A
--- @generic B
--- @generic C
--- @generic D
--- @generic E
--- @generic F
--- @generic G
--- @generic H
--- @generic I
--- @generic J
--- @generic K
--- @generic L
--- @generic M
--- @generic N
--- @generic O
--- @generic P
--- @generic Q
--- @generic R
--- @generic S
--- @generic T
---
--- @type fun(ab: fun(...: any): B): fun(...: any): B
--- @type fun(ab: fun(...: any): B, fun(b: B): C): fun(...: any): C
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D): fun(...: any): D
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E): fun(...: any): E
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F): fun(...: any): F
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G): fun(...: any): G
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H): fun(...: any): H
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I): fun(...: any): I
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J): fun(...: any): J
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K): fun(...: any): K
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L): fun(...: any): L
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M): fun(...: any): M
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N): fun(...: any): N
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O): fun(...: any): O
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P): fun(...: any): P
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q): fun(...: any): Q
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R): fun(...: any): R
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R, fun(c: R): S): fun(...: any): S
--- @type fun(ab: fun(...: any): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R, fun(c: R): S, fun(c: S): T): fun(...: any): T
local function flow (...)

   -- unrolling the first 20 iterations of the loop  for  better
   -- performance; it's extremely rare that  anyone  would  need
   -- anything more. it is also split in two to keep the  lookup
   -- time minimal for the latter part.

   local count = select('#', ...)
   local funcs = { ... }

   assert(count > 0, 'expected at least one function as argument to `flow`')

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

return flow
