;; extends

;; Whole mappings.
;;
;; ```yaml
;; -  property: foobar
;; #  ╰──────────────╯
;; #         ╰─────────────────╮
;;    other_property: foobaz # │
;; #  ╰────────────────────╯   │
;; #       ╰─ captures ────────╯
;; ```
(block_mapping_pair) @swappable

;; Items in sequences.
;;
;; ```yaml
;; - foobar
;; # ╰────╯
;; #   ╰────────────╮
;; - foobaz #       │
;; # ╰────╯         │
;; #   ╰─ captures ─╯
;; ```
(block_sequence_item) @swappable
