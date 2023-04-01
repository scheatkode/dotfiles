configure yast colorscheme:
  file.replace:
    - name: /etc/sysconfig/yast2
    - pattern: Y2NCURSES_COLOR_THEME=""
    - repl: Y2NCURSES_COLOR_THEME="rxvt"
    - count: 1
    - ignore_if_missing: true
    - parallel: true
