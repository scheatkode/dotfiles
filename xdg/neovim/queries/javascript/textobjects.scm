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
;; ```javascript
;; func(Math.PI,  Math.E)
;; //   ╰─────╯   ╰────╯
;; //    ╰─ captures ─╯
;; ```
(arguments (_) @swappable)

;; branches of ternary expressions
;;
;; ```javascript
;; true ? do_something() : do_nothing()
;; //     ╰────────────╯   ╰──────────╯
;; //            ╰─ captures ─╯
;; ```
(ternary_expression [consequence: (_) alternative: (_)] @swappable)

;; Properties of objects.
;;
;; ```javascript
;; const obj = { property1: 1, property2: 2 }
;; //            ╰──────────╯  ╰──────────╯
;; //                 ╰─ captures ─╯
;; func({ property1, property2 })
;; //     ╰───────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(object (pair) @swappable)

;; Items of arrays.
;;
;; ```javascript
;; const arr = [ member1, member2 ]
;; //            ╰─────╯  ╰─────╯
;; //             ╰─ captures ─╯
;; ```
(array (_) @swappable)
