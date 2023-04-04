{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config") -%}

link neovim config:
  file.symlink:
    - name: {{ xdg_config_home }}/nvim
    - target: {{ root }}/config/neovim
    - backupname: {{ xdg_config_home }}/nvim.back
    - user: {{ user }}
    - group: {{ user }}
    - force: true
    - makedirs: true
    - parallel: true
    - require:
      - file: xdg prepare directories
