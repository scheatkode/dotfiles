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
(
 (command
	name: (_) @_command
	argument: [(string) (raw_string)] @awk)
 (#any-of? @_command "awk" "gawk" "nawk" "mawk")
)

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
(
 (redirected_statement
	redirect: (heredoc_redirect (heredoc_start) @_heredoc_name))
 (#any-of? @_heredoc_name "JQ" "jq")
 (heredoc_body) @jq
)

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
(
 (command
	name: (_) @_command
	argument: [(string) (raw_string)] @jq)
 (#eq? @_command "jq")
)

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
(
 (command
	argument: [(string) (raw_string)] @jq)
 (#contains? @jq "# jq")
)
