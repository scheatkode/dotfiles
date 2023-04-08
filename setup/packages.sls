{% set patterns = salt.pkg.list_installed_patterns() %}

install packages:
  pkg.installed:
    - parallel: true
    - retry:
        attempts: 5
        interval: 2
    - pkgs:
        - 7zip
        - MozillaFirefox
        - alsa
        - anydesk
        - aria2
        - awesome
        - bat
        - btop
        - cargo
        - curl
        - dog
        - exa
        - fd
        - ffmpeg-6
        - fzf
        - gdb
        - ghostscript
        - git
        - git-crypt
        - git-delta
        - gnu_parallel
        - gpg2
        - helvum
        - htop
        - hyperfine
        - imv
        - jq
        - keepassxc
        - maim
        - mpclient
        - mpd
        - mpv
        - ncmpcpp
        - neovim
        - nmap
        - nodejs18
        - openfortivpn
        - openvpn
        - opi
        - pinentry-gtk2
        - pipewire
        - pipewire-alsa
        - pipewire-pulseaudio
        - pipewire-tools
        - podman
        - python
        - rclone
        - remmina
        - remmina-plugin-rdp
        - remmina-plugin-spice
        - remmina-plugin-vnc
        - ripgrep
        - rsync
        - simple-mtpfs
        - simple-scan
        - sqlite3
        - telegram-desktop
        - terraform
        - transmission-daemon
        - transmission-web-control
        - wavemon
        - wezterm
        - wireplumber
        - wireplumber-audio
        - wireshark
        - xclip
        - yq
        - zathura
        - zathura-plugin-pdf-poppler
        - zoxide
        - zsh

          {%- if "devel_basis" not in patterns %}
        - pattern:devel_basis
          {%- endif %}
          {%- if "kvm_server" not in patterns %}
        - pattern:kvm_server
          {%- endif %}
          {%- if "kvm_tools" not in patterns %}
        - pattern:kvm_tools
          {%- endif %}


after-install cleanup:
  pkg.purged:
    - parallel: true
    - require:
      - pkg: install packages
    - pkgs:
      - vim
      - xclock
      - xterm

  service.dead:
    - parallel: true
    - require:
      - pkg: install packages
    - names:
      - anydesk:
        - enable: false
