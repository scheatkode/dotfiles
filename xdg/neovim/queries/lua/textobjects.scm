((field)        @swappable)
(arguments  (_) @swappable)
(parameters (_) @swappable)

;; in multiple variable assignment
;; ```lua
;; local has_module, module = pcall(require, 'some.module')
;; --    ╰────────╯  ╰────╯
;; --      ╰─ captures ─╯
;; ```
(assignment_statement (variable_list name: (identifier) @swappable))
