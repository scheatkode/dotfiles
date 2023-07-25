;; extends

;; Docstrings:
;; These are complements to the highlights provided by `nvim-treesitter`.

;; Top-level docstrings not being the first occurrence. This is helpful
;; when the docstring is following a shebang.
;; ```python
;; #!/usr/bin/env python3
;;
;; """Some docstring here"""
;; #  ╰────────────────────╯
;; #    capture ─╯
;; ```
(module
  (expression_statement (string) @string.documentation @spell) @_statement
  (#nth? @_statement 1))

;; Attribute docstrings in class definitions.
;; ```python
;; class SomeClass:
;;     """
;;     The class docstring.
;;     """
;;
;;     attribute_one = 0
;;     """Represents an attribute."""
;; #   ╰────────────────────────────╯
;; #                ╰────────────────────╮
;;     attribute_two = 1              #  │
;;     """Represents an attribute.""" #  │
;; #   ╰────────────────────────────╯    │
;; #               ╰── captures ─────────╯
;; ```
(class_definition
  body: (block
          (expression_statement (string) @string.documentation @spell) @_statement
          (#not-nth? @_statement 0)))
