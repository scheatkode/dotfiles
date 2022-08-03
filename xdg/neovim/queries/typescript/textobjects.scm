; inherits: javascript

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
