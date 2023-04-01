{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config") -%}

install custom keyboard definitions:
  file.copy:
    - name: /usr/share/X11/xkb/symbols/xcustom
    - source: {{ root }}/etc/xkb/symbols/xcustom
    - parallel: true

activate custom keyboard definitions:
  file.blockreplace:
    - names:
      - /usr/share/X11/xkb/rules/base
      - /usr/share/X11/xkb/rules/evdev
    - insert_after_match: '^!\s*option\s*=\s*symbols$'
    - marker_start: '  # -- Start of managed block'
    - marker_end: '  # -- End of managed block'
    - content: |2
          xcustom:kbd_keypad = +xcustom(kbd_keypad)
          xcustom:kbd_hexpad = +xcustom(kbd_hexpad)
