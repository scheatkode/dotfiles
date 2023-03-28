;; extends

;; Sibling pairs.
;;
;; ```json
;;    "property:" "foobar",
;; // ╰──────────────────╯
;; //        ╰──────────────────────╮
;;    "other_property:" "foobaz" // │
;; // ╰────────────────────────╯    │
;; //      ╰─ captures ─────────────╯
;; ```
(pair) @swappable

;; Items in arrays.
;;
;; ```json
;; "array": [
;;    "foobar",
;; // ╰──────╯
;; //    ╰──────────╮
;;    "foobaz" //   │
;; // ╰──────╯      │
;; //  ╰─ captures ─╯
;; ]
;; ```
(array (_) @swappable)
