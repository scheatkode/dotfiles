{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config") -%}

link gnupg config:
  file.symlink:
    - name: {{ xdg_config_home }}/gnupg
    - target: {{ root }}/config/gpg
    - backupname: {{ xdg_config_home }}/gnupg.back
    - user: {{ user }}
    - group: {{ user }}
    - force: true
    - makedirs: true
    - parallel: true
    - require:
      - file: xdg prepare directories

ensure correct permissions:
  file.directory:
    - name: {{ root }}/config/gpg
    - user: {{ user }}
    - group: {{ user }}
    - file_mode: "0600"
    - dir_mode: "0700"
    - parallel: true
    - recurse:
      - user
      - group
      - mode
