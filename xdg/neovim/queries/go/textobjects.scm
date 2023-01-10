(field_declaration_list (field_declaration) @swappable)
(literal_value          (keyed_element)     @swappable)
(literal_value          (literal_element)   @swappable)

(function_declaration parameters: (parameter_list (parameter_declaration) @swappable))
(method_declaration   parameters: (parameter_list (parameter_declaration) @swappable))

;; members of expression lists
;;
;; ```go
;;    some_variable, err := do_something()
;; // ╰───────────╯  ╰─╯
;; //  ╰── captures ──╯
;; ```
(expression_list (_) @swappable)

;; arguments of function calls
;;
;; ```go
;; do_something(some_variable, some_other_variable)
;; //           ╰───────────╯  ╰─────────────────╯
;; //                ╰── captures ──╯
;; ```
(argument_list (_) @swappable)
