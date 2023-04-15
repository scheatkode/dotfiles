{%- macro join() -%}
{{ salt.file.normpath(salt.file.join(*varargs)) }}
{%- endmacro -%}

{%- macro get(env) -%}
{{ salt.environ.get(env, join(*varargs)) }}
{%- endmacro -%}

{%- set user = salt.environ.get("EUSER") -%}
{%- set home = get("EHOME", "/home", user) -%}

{%- set XDG_CACHE_HOME  = get("XDG_CACHE_HOME",  home,     ".cache") -%}
{%- set XDG_CONFIG_HOME = get("XDG_CONFIG_HOME", home,     ".config") -%}
{%- set XDG_DATA_HOME   = get("XDG_DATA_HOME",   home,     ".local", "share") -%}
{%- set XDG_STATE_HOME  = get("XDG_STATE_HOME",  home,     ".local", "state") -%}
{#-
  The spec doesn't refer to this directory, it exists by convention and
  I think it's nice to have
-#}
{%- set XDG_BIN_HOME    = join(XDG_DATA_HOME, "..", "bin") -%}

xdg prepare directories:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: "0755"
    - makedirs: true
    - parallel: true
    - names:
      - {{ XDG_CACHE_HOME }}
      - {{ XDG_CONFIG_HOME }}
      - {{ XDG_DATA_HOME }}
      - {{ XDG_STATE_HOME }}
      - {{ XDG_BIN_HOME }}
