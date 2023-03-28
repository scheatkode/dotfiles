{%- set user = salt.environ.get("EUSER") -%}

prepare xdg directories:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: "0755"
    - makedirs: true
    - parallel: true
    - names:
        - /home/{{ user }}/.cache/
        - /home/{{ user }}/.config/
        - /home/{{ user }}/.local/bin/
        - /home/{{ user }}/.local/share/
        - /home/{{ user }}/.local/state/
