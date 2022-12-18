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
---NOTE: The piped functions should be unary, meaning they
---      should take only 1 parameter, and have 1 return value.
---      For the n-ary version, see `pipe_nary`.
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
local pipe

if jit then
	pipe = function(a, ...)
		-- LuaJIT is better at optimizing loops than we are. This is consistently
		-- ~100x faster than the alternatives.

		local result = a

		for i = 1, select('#', ...) do
			result = select(i, ...)(result)
		end

		return result
	end
else
	pipe = function(a, ...)
		-- Vanilla Lua doesn't do loop optimizations, we gotta do it ourselves by
		-- unrolling the first 20 iterations of the loop for better performance;
		-- it's extremely rare that anyone would need anything more. it is also
		-- split in two to keep the lookup time minimal for the latter part.

		local count = select('#', ...)
		local funcs = { ... }

		if count < 11 then
			if count == 1 then
				return funcs[1](a)
			end
			if count == 2 then
				return funcs[2](funcs[1](a))
			end
			if count == 3 then
				return funcs[3](funcs[2](funcs[1](a)))
			end
			if count == 4 then
				return funcs[4](funcs[3](funcs[2](funcs[1](a))))
			end
			if count == 5 then
				return funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
			end
			if count == 6 then
				return funcs[6](
					funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
				)
			end
			if count == 7 then
				return funcs[7](
					funcs[6](funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a))))))
				)
			end
			if count == 8 then
				return funcs[8](
					funcs[7](
						funcs[6](
							funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
						)
					)
				)
			end
			if count == 9 then
				return funcs[9](
					funcs[8](
						funcs[7](
							funcs[6](
								funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
							)
						)
					)
				)
			end
			if count == 0 then
				return a
			end

			return funcs[10](
				funcs[9](
					funcs[8](
						funcs[7](
							funcs[6](
								funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
							)
						)
					)
				)
			)
		end

		if count < 21 then
			if count == 10 then
				return funcs[10](
					funcs[9](
						funcs[8](
							funcs[7](
								funcs[6](
									funcs[5](funcs[4](funcs[3](funcs[2](funcs[1](a)))))
								)
							)
						)
					)
				)
			end
			if count == 11 then
				return funcs[11](
					funcs[10](
						funcs[9](
							funcs[8](
								funcs[7](
									funcs[6](
										funcs[5](
											funcs[4](funcs[3](funcs[2](funcs[1](a))))
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 12 then
				return funcs[12](
					funcs[11](
						funcs[10](
							funcs[9](
								funcs[8](
									funcs[7](
										funcs[6](
											funcs[5](
												funcs[4](funcs[3](funcs[2](funcs[1](a))))
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 13 then
				return funcs[13](
					funcs[12](
						funcs[11](
							funcs[10](
								funcs[9](
									funcs[8](
										funcs[7](
											funcs[6](
												funcs[5](
													funcs[4](
														funcs[3](funcs[2](funcs[1](a)))
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 14 then
				return funcs[14](
					funcs[13](
						funcs[12](
							funcs[11](
								funcs[10](
									funcs[9](
										funcs[8](
											funcs[7](
												funcs[6](
													funcs[5](
														funcs[4](
															funcs[3](funcs[2](funcs[1](a)))
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 15 then
				return funcs[15](
					funcs[14](
						funcs[13](
							funcs[12](
								funcs[11](
									funcs[10](
										funcs[9](
											funcs[8](
												funcs[7](
													funcs[6](
														funcs[5](
															funcs[4](
																funcs[3](
																	funcs[2](funcs[1](a))
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 16 then
				return funcs[16](
					funcs[15](
						funcs[14](
							funcs[13](
								funcs[12](
									funcs[11](
										funcs[10](
											funcs[9](
												funcs[8](
													funcs[7](
														funcs[6](
															funcs[5](
																funcs[4](
																	funcs[3](
																		funcs[2](funcs[1](a))
																	)
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 17 then
				return funcs[17](
					funcs[16](
						funcs[15](
							funcs[14](
								funcs[13](
									funcs[12](
										funcs[11](
											funcs[10](
												funcs[9](
													funcs[8](
														funcs[7](
															funcs[6](
																funcs[5](
																	funcs[4](
																		funcs[3](
																			funcs[2](funcs[1](a))
																		)
																	)
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 18 then
				return funcs[18](
					funcs[17](
						funcs[16](
							funcs[15](
								funcs[14](
									funcs[13](
										funcs[12](
											funcs[11](
												funcs[10](
													funcs[9](
														funcs[8](
															funcs[7](
																funcs[6](
																	funcs[5](
																		funcs[4](
																			funcs[3](
																				funcs[2](
																					funcs[1](a)
																				)
																			)
																		)
																	)
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end
			if count == 19 then
				return funcs[19](
					funcs[18](
						funcs[17](
							funcs[16](
								funcs[15](
									funcs[14](
										funcs[13](
											funcs[12](
												funcs[11](
													funcs[10](
														funcs[9](
															funcs[8](
																funcs[7](
																	funcs[6](
																		funcs[5](
																			funcs[4](
																				funcs[3](
																					funcs[2](
																						funcs[1](a)
																					)
																				)
																			)
																		)
																	)
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			end

			return funcs[20](
				funcs[19](
					funcs[18](
						funcs[17](
							funcs[16](
								funcs[15](
									funcs[14](
										funcs[13](
											funcs[12](
												funcs[11](
													funcs[10](
														funcs[9](
															funcs[8](
																funcs[7](
																	funcs[6](
																		funcs[5](
																			funcs[4](
																				funcs[3](
																					funcs[2](
																						funcs[1](a)
																					)
																				)
																			)
																		)
																	)
																)
															)
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			)
		end

		local result = a

		for i = 1, count do
			result = select(i, ...)(result)
		end

		return result
	end
end

return pipe
