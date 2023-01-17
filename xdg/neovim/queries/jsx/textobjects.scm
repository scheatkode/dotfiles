;; extends

;; Attributes in JSX.
;; ```jsx
;; <div classname='w-full h-full' id='div-1' />
;; //   ╰───────────────────────╯ ╰────────╯
;; //                    ╰─ captures ─╯
;; ```
(jsx_attribute) @swappable

;; Attributes & expressions in JSX.
;; ```jsx
;; <div classname='w-full h-full' ref={ref} />
;; //   ╰───────────────────────╯ ╰───────╯
;; //                    ╰─ captures ─╯
;; ```
(_ attribute: [
	(jsx_expression)
	(jsx_attribute)
] @swappable)
