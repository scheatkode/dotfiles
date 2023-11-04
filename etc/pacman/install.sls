install pacman config:
  file.managed:
    - name: /etc/pacman.conf
    - source: salt://etc/pacman/pacman.conf
    - parallel: true

install pacman hooks:
  file.recurse:
    - names:
      - /etc/pacman.d/hooks/:
        - source: salt://etc/pacman/hooks/
      - /etc/pacman.d/hooks.bin/:
        - source: salt://etc/pacman/hooks.bin/
        - file_mode: "0755"
    - parallel: true
    - clean: true
