--- pipe  the  value  of  an   expression  into  a  pipeline  of
--- functions, effectively calling every function on the  return
--- value of the previous one.
---
--- @see flow
---
--- ```lua
--- local pipe = require('f.function.pipe')
---
--- local length = function(s: string): number return #s    end
--- local double = function(n: number): number return n * 2 end
---
--- -- without pipe
--- assert.same(6, double(length('foo')))
---
--- -- with pipe
--- assert.same(6, pipe('foo', length, double)
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
--- @type fun(a: A, ab: fun(a: A): B): B
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C): C
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D): D
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E): E
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F): F
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G): G
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H): H
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I): I
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J): J
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K): K
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L): L
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M): M
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N): N
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O): O
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P): P
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q): Q
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R): R
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R, fun(c: R): S): S
--- @type fun(a: A, ab: fun(a: A): B, fun(b: B): C, fun(c: C): D, fun(c: D): E, fun(c: E): F, fun(c: F): G, fun(c: G): H, fun(c: H): I, fun(c: I): J, fun(c: J): K, fun(c: K): L, fun(c: L): M, fun(c: M): N, fun(c: N): O, fun(c: O): P, fun(c: P): Q, fun(c: Q): R, fun(c: R): S, fun(c: S): T): T
local function pipe (a, ...)

   -- unrolling the first 20 iterations of the loop  for  better
   -- performance; it's extremely rare that  anyone  would  need
   -- anything more. it is also split in two to keep the  lookup
   -- time minimal for the latter part.

   local count = select('#', ...)
   local funcs = { ... }

   if count < 11 then
      if count == 1 then return funcs[1](a) end
      if count == 2 then return funcs[2](funcs[1](a)) end
      if count == 3 then return funcs[3](funcs[2](funcs[1](a))) end
      if count == 4 then return funcs[4](funcs[3](funcs[2](funcs[1](a)))) end
      if count == 5 then return funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))) end
      if count == 6 then return funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))) end
      if count == 7 then return funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))) end
      if count == 8 then return funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))) end
      if count == 9 then return funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))) end
      if count == 0 then return a end

      return funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))
   end

   if count < 21 then
      if count == 10 then return funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))))) end
      if count == 11 then return funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))) end
      if count == 12 then return funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))))))) end
      if count == 13 then return funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))))) end
      if count == 14 then return funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))))))))) end
      if count == 15 then return funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))))))) end
      if count == 16 then return funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))))))))))) end
      if count == 17 then return funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))))))))) end
      if count == 18 then return funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))))))))))))))) end
      if count == 19 then return funcs[19](funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))))))))))) end

      return funcs[20](funcs[19](funcs[18](funcs[17](funcs[16](funcs[15](funcs[14](funcs[13](funcs[12](funcs[11](funcs[10](funcs[9](funcs[8](funcs[7](funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))))))))))))))))
   end

   local result = a

   for i = 1, count do
      result = select(i, ...)(result)
   end

   return result
end

return pipe
