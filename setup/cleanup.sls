{%- set user = salt.environ.get("EUSER") -%}

remove extra files from home:
  file.absent:
    - parallel: true
    - names:
      - /home/{{ user }}/.dmrc
      - /home/{{ user }}/.emacs
      - /home/{{ user }}/.i18n
      - /home/{{ user }}/.inputrc
      - /home/{{ user }}/.viminfo
      - /home/{{ user }}/.xim.template
