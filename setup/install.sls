{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config") -%}

{%- set blacklist = (".", "..", "profile") -%}
{%- set all_configs = salt.file.readdir(root ~ "/config") | reject("in", blacklist) -%}
{%- set vanilla_configs = [] -%}
{%- set custom_configs = [] -%}

{%- for config in all_configs %}
  {%- if salt.file.file_exists(root ~ "/config/" ~ config ~ "/install.sls") %}
{%- do custom_configs.append(config) -%}
  {%- else %}
{%- do vanilla_configs.append(config) -%}
  {%- endif -%}
{%- endfor -%}

{%- if custom_configs | length() > 0 %}
include:
  {%- for config in custom_configs %}
  - config.{{ config }}.install
  {%- endfor -%}
{%- endif %}

link dotfile configs:
  file.symlink:
    - user: {{ user }}
    - group: {{ user }}
    - force: true
    - makedirs: true
    - parallel: true
    - names:
      - /home/{{ user }}/.profile:
        - target: {{ root }}/config/profile
      - {{ xdg_config_home }}/lib:
        - target: {{ root }}/lib
{%- for config in vanilla_configs %}
      - {{ xdg_config_home }}/{{ config }}:
        - target: {{ root }}/config/{{ config }}
        - backupname: {{ xdg_config_home }}/{{ config }}.back
{%- endfor %}
    - require:
      - file: prepare xdg directories
