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

;; identifiers in named imports
;;
;; ```typescript
;; import { access, ftruncate } from 'fs'
;; //       ╰────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(named_imports (import_specifier) @swappable)
