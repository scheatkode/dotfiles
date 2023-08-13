;; inline awk script
;;
;; ```bash
;; awk \
;; '
;; /^foobar/ {          #  ─────╮
;;    printf "%s\n", $2 #       │─╮
;; }                    #  ─────╯ │
;; '                    #         │
;; # injection ───────────────────╯
;; ```
((command
	name: (_) @_command
	argument: [(string) (raw_string)] @injection.content)
 (#any-of? @_command "awk" "gawk" "nawk" "mawk")
 (#set! injection.language "awk"))

;; redirect heredocs named "jq"
;;
;; ```bash
;; cat <<JQ #
;; # Body of the jq query here                    ─────╮
;; [                                           #       │
;;    .[] | filter(.name | contains("foobar")) #       │─╮
;; ]                                           #  ─────╯ │
;; JQ                                          #         │
;; # injection ──────────────────────────────────────────╯
;; ```
((redirected_statement
	redirect: (heredoc_redirect (heredoc_start) @_heredoc_name))
 (#any-of? @_heredoc_name "JQ" "jq")
 (heredoc_body) @injection.content
 (#set! injection.language "jq"))

;; direct jq queries
;;
;; ```bash
;; jq -r \
;; '
;; # Body of the jq query here                    ─────╮
;; [                                           #       │
;;    .[] | filter(.name | contains("foobar")) #       │─╮
;; ]                                           #  ─────╯ │
;; '                                           #         │
;; # injection ──────────────────────────────────────────╯
;; ```
((command
	name: (_) @_command
	argument: [(string) (raw_string)] @injection.content)
 (#eq? @_command "jq")
 (#set! injection.language "jq"))

;; strings containing a "# jq" comment
;;
;; ```bash
;; cat \
;; '
;; # jq                                           ─────╮
;; [                                           #       │
;;    .[] | filter(.name | contains("foobar")) #       │─╮
;; ]                                           #  ─────╯ │
;; '                                           #         │
;; # injection ──────────────────────────────────────────╯
;; ```
((command
	argument: [(string) (raw_string)] @injection.content)
 (#contains? @injection.content "# jq")
 (#set! injection.language "jq"))
