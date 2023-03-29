{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}

{%- set xdg_config_home = salt.environ.get("XDG_CONFIG_HOME", "/home/" ~ user ~ "/.config")      -%}
{%- set xdg_data_home   = salt.environ.get("XDG_DATA_HOME",   "/home/" ~ user ~ "/.local/share") -%}

{%- set blacklist = (".", "..", "profile") -%}

{%- set all_configs = salt.file.readdir(root ~ "/config") | reject("in", blacklist) -%}
{%- set vanilla_configs = [] -%}
{%- set custom_configs = [] -%}

{%- set all_data = salt.file.readdir(root ~ "/data") | reject("in", blacklist) -%}
{%- set vanilla_data = [] -%}
{%- set custom_data = [] -%}

{%- for config in all_configs %}
  {%- if salt.file.file_exists(root ~ "/config/" ~ config ~ "/install.sls") %}
{%- do custom_configs.append(config) -%}
  {%- else %}
{%- do vanilla_configs.append(config) -%}
  {%- endif -%}
{%- endfor -%}

{%- for data in all_data %}
  {%- if salt.file.file_exists(root ~ "/data/" ~ data ~ "/install.sls") %}
{%- do custom_data.append(data) -%}
  {%- else %}
{%- do vanilla_data.append(data) -%}
  {%- endif -%}
{%- endfor -%}

{%- if custom_configs | length() > 0 or custom_data | length() > 0 %}
include:
  {%- for config in custom_configs %}
  - config.{{ config }}.install
  {%- endfor -%}
  {%- for data in custom_data %}
  - data.{{ data }}.install
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
{%- for data in vanilla_data %}
      - {{ xdg_data_home }}/{{ data }}:
        - target: {{ root }}/data/{{ data }}
        - backupname: {{ xdg_data_home }}/{{ data }}.back
{%- endfor %}
    - require:
      - file: prepare xdg directories
