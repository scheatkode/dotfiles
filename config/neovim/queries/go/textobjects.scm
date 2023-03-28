;; extends

;; elements of struct definition
;;
;; ```go
;; type Struct struct { some_variable int; some_other_variable any }
;; //                  ╰────────────────╯  ╰─────────────────────╯
;; //                              ╰── captures ──╯
;; ```
(field_declaration_list (field_declaration) @swappable)

;; keyed elements of struct literal
;;
;; ```go
;; v := SomeStruct{A: some_variable, B: some_other_variable}
;; //              ╰──────────────╯  ╰────────────────────╯
;; //                      ╰── captures ──╯
;; ```
(literal_value (keyed_element)   @swappable)

;; un-keyed elements of struct literal
;;
;; ```go
;; v := SomeStruct{some_variable, some_other_variable}
;; //              ╰───────────╯  ╰─────────────────╯
;; //                    ╰── captures ──╯
;; ```
(literal_value (literal_element) @swappable)

;; parameters of function declarations
;;
;; ```go
;; func do_something(some_variable int, some_other_variable any)
;; //                ╰───────────────╯  ╰─────────────────────╯
;; //                          ╰── captures ──╯
;; ```
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
