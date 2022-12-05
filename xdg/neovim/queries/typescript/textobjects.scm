;; formal parameters in function declarations
;;
;; ```typescript
;; const func = (x: number,  y = 0) => 2 * x + y
;; //            ╰───────╯   ╰───╯
;; //              ╰─ captures ─╯
;; ```
(formal_parameters (_) @swappable)

;; arguments in function call expressions
;;
;; ```typescript
;; func(Math.PI,  Math.E)
;; //   ╰─────╯   ╰────╯
;; //    ╰─ captures ─╯
;; ```
(arguments (_) @swappable)

;; branches of ternary expressions
;;
;; ```typescript
;; true ? do_something() : do_nothing()
;; //     ╰────────────╯   ╰──────────╯
;; //            ╰─ captures ─╯
;; ```
(ternary_expression [consequence: (_) alternative: (_)] @swappable)

;; Properties of objects.
;;
;; ```typescript
;; const obj = { property1: 1, property2: 2 }
;; //            ╰──────────╯  ╰──────────╯
;; //                 ╰─ captures ─╯
;; func({ property1, property2 })
;; //     ╰───────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(object (pair) @swappable)

;; Properties of objects.
;;
;; ```typescript
;; const obj = { property1: 1, property2: 2 }
;; //            ╰──────────╯  ╰──────────╯
;; //                 ╰─ captures ─╯
;; func({ property1, property2 })
;; //     ╰───────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(object_pattern (_) @swappable)

;; Items of arrays.
;;
;; ```typescript
;; const arr = [ member1, member2 ]
;; //            ╰─────╯  ╰─────╯
;; //             ╰─ captures ─╯
;; ```
(array (_) @swappable)

;; Identifiers in named imports.
;;
;; ```typescript
;; import { access, ftruncate } from 'fs'
;; //       ╰────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(named_imports (import_specifier) @swappable)

;; Type arguments.
;;
;; ```typescript
;; const defaults: Omit<'some_options', Options> = {}
;; //                    ╰──────────╯  ╰──────╯
;; //                        ╰─ captures ─╯
;; ```
(type_arguments (_) @swappable)

;; Properties in type declarations.
;;
;; ```typescript
;; interface ISomething {
;;    property: number
;; // ╰──────────────╯
;; //        ╰──────────────────╮
;;    other_property: number // │
;; // ╰────────────────────╯    │
;; //      ╰─ captures ─────────╯
;; }
;; ```
(property_signature) @swappable

;; Elements of tuple types.
;; ```typescript
;; type Tuple: [SomeType, SomeOtherType]
;; //           ╰──────╯  ╰───────────╯
;; //              ╰─ captures ─╯
;; ```
(tuple_type (_) @swappable)
