; inherits javascript

;; identifiers in named imports
;;
;; ```typescript
;; import { access, ftruncate } from 'fs'
;; //       ╰────╯  ╰───────╯
;; //        ╰─ captures ─╯
;; ```
(named_imports (import_specifier) @swappable)

;; type arguments
;;
;; ```typescript
;; const defaults: Omit<'some_options', Options> = {}
;; //                    ╰──────────╯  ╰──────╯
;; //                        ╰─ captures ─╯
;; ```
(type_arguments (_) @swappable)
