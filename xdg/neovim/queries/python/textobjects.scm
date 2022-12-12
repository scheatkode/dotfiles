;; Arguments in function calls.
;; ```python
;; print('something', 'something else')
;; #     ╰─────────╯  ╰──────────────╯
;; #          ╰─ captures ─╯
;; ```
(argument_list (_) @swappable)

;; Formal parameters in function declarations.
;; ```python
;; def func(arg0: str, arg1: int)
;; #        ╰───────╯  ╰───────╯
;; #          ╰─ captures ─╯
;; ```
(parameters (_) @swappable)

;; Branches in conditional expressions.
;; ```python
;; var = "something" if something else "something else"
;; #     ╰─────────╯                   ╰──────────────╯
;; #            ╰─────── captures ───────╯
;; ```
[
	(conditional_expression . (_) @swappable)
	(conditional_expression (_) @swappable .)
]

;; Members of lists.
;; ```python
;; some_list = [member0, member1]
;; #           ╰──────╯  ╰─────╯
;; #             ╰ captures ╯
;; ```
(list (_) @swappable)

;; Members of tuples.
;; ```python
;; some_tuple = (member0, member1)
;; #             ╰─────╯  ╰─────╯
;; #               ╰ captures ╯
;; ```
(tuple (_) @swappable)

;; in multiple variable assignment
;; ```python
;;   return0, return1 = func(arg0, arg1)
;; # ╰─────╯  ╰─────╯
;; #  ╰─ captures ─╯
;; ```
(pattern_list (identifier) @swappable)
