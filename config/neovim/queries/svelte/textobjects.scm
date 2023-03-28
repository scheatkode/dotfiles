;; extends

;; element attributes
;;
;; ```html
;; <div class="some-class" style="some: style;" />
;; //   ╰────────────────╯ ╰──────────────────╯
;; //              ╰─ captures ─╯
;; ```
(element (_ (attribute) @swappable))
