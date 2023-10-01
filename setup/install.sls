{%- macro join() -%}
{{ salt.file.normpath(salt.file.join(*varargs)) }}
{%- endmacro -%}

{%- macro get(env) -%}
{{ salt.environ.get(env, join(*varargs)) }}
{%- endmacro -%}

{%- macro file_exists() -%}
{{ salt.file.file_exists(join(*varargs)) | json }}
{%- endmacro -%}

{%- macro readdir() -%}
{{ salt.file.readdir(join(*varargs)) | json }}
{%- endmacro -%}

{%- set user = salt.environ.get("EUSER") -%}
{%- set root = salt.environ.get("PWD") -%}
{%- set home = get("EHOME", "/home", user) -%}

{%- set XDG_CONFIG_HOME = get("XDG_CONFIG_HOME", home, ".config") -%}
{%- set XDG_DATA_HOME   = get("XDG_DATA_HOME",   home, ".local", "share") -%}
{%- set XDG_BIN_HOME    = join(XDG_DATA_HOME, "..", "bin") -%}
{%- set BIN_HOME        = join(home, "bin") -%}

{%- set blacklist = (".", "..", "profile") -%}

{%- set vanilla_configs = [] -%}
{%- set custom_configs  = [] -%}
{%- set etc_configs     = [] -%}

{%- set vanilla_data = [] -%}
{%- set custom_data  = [] -%}

{%- for config in readdir(root, "config") | load_json | reject("in", blacklist) %}
  {%- if file_exists(root, "config", config, "install.sls") | load_json %}
{%- do custom_configs.append(config) -%}
  {%- else %}
{%- do vanilla_configs.append(config) -%}
  {%- endif -%}
{%- endfor -%}

{%- for config in readdir(root, "etc") | load_json | reject("in", blacklist) %}
  {%- if file_exists(root, "etc", config, "install.sls") | load_json %}
{%- do etc_configs.append(config) -%}
  {%- endif -%}
{%- endfor -%}

{%- for data in readdir(root, "data") | load_json | reject("in", blacklist) %}
  {%- if file_exists(root, "data", data, "install.sls") | load_json %}
{%- do custom_data.append(data) -%}
  {%- else %}
{%- do vanilla_data.append(data) -%}
  {%- endif -%}
{%- endfor -%}

{%- if custom_configs | length() > 0
    or etc_configs    | length() > 0
    or custom_data    | length() > 0
%}
include:
  {%- for config in custom_configs %}
  - config.{{ config }}.install
  {%- endfor -%}
  {%- for config in etc_configs %}
  - etc.{{ config }}.install
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
      - {{ join(home, ".profile") }}:
        - target: {{ join(root, "config", "profile") }}
      - {{ join(XDG_CONFIG_HOME, "lib") }}:
        - target: {{ join(root, "lib") }}
{%- for config in vanilla_configs %}
      - {{ join(XDG_CONFIG_HOME, config) }}:
        - target: {{ join(root, "config", config) }}
        - backupname: {{ join(XDG_CONFIG_HOME, config ~ ".back") }}
{%- endfor %}
{%- for data in vanilla_data %}
      - {{ join(XDG_DATA_HOME, data) }}:
        - target: {{ join(root, "data", data) }}
        - backupname: {{ join(XDG_DATA_HOME, data ~ ".back") }}
{%- endfor %}
{%- for bin in readdir(root, "bin") | load_json | reject("in", blacklist) %}
      - {{ join(XDG_BIN_HOME, bin) }}:
        - target: {{ join(root, "bin", bin) }}
        - backupname: {{ join(XDG_BIN_HOME, bin ~ ".back") }}
{%- endfor %}
      - {{ BIN_HOME }}:
        - target: {{ join(root, "bin") }}
        - backupname: {{ join(BIN_HOME, "bin.back") }}
    - require:
      - file: xdg prepare directories
