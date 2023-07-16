;; extends
;; inherits: ecma

;; Type arguments.
;;
;; ```typescript
;; const defaults: Omit<'some_options', Options> = {}
;; //                    ╰──────────╯  ╰──────╯
;; //                        ╰─ captures ─╯
;; ```
(type_arguments (_) @swappable)

;; Type parameters.
;;
;; ```typescript
;; type ValueOf<TData, TOptions> = `${TData[TOptions]}`;
;; //           ╰───╯  ╰──────╯
;; //            ╰─ captures ─╯
;; ```
(type_parameter) @swappable

;; Properties in type declarations.
;;
;; ```typescript
;; interface ISomething {
;;    property: number
;; // ╰──────────────╯
;; //        ╰──────────────────╮
;;    other_property: number // │
;; // ╰────────────────────╯    │
;; //      ╰─ captures ─────────╯
;; }
;; ```
(property_signature) @swappable

;; Elements of tuple types.
;; ```typescript
;; type Tuple: [SomeType, SomeOtherType]
;; //           ╰──────╯  ╰───────────╯
;; //              ╰─ captures ─╯
;; ```
(tuple_type (_) @swappable)

;; Types of union type.
;; ```typescript
;; type Union: SomeType | SomeOtherType
;; //          ╰──────╯   ╰───────────╯
;; //              ╰─ captures ─╯
;; ```
(union_type (_) @swappable)
