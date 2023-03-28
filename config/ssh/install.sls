{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config") -%}

ensure secure permissions:
  file.directory:
    - name: {{ xdg_config_home }}/ssh
    - user: {{ user }}
    - group: {{ user }}
    - file_mode: "0600"
    - dir_mode: "0700"
    - parallel: true
    - recurse:
      - user
      - group
      - mode

link ssh config:
  file.symlink:
    - user: {{ user }}
    - group: {{ user }}
    - force: true
    - makedirs: true
    - parallel: true
    - require:
      - file: prepare xdg directories
      - file: ensure secure permissions
    - names:
      - {{ xdg_config_home }}/ssh:
        - target: {{ root }}/config/ssh
        - backupname: {{ xdg_config_home }}/ssh.back
      - /home/{{ user }}/.ssh:
        - target: {{ root }}/config/ssh
        - backupname: /home/{{ user }}/.ssh.back
