authenticate repositories:
  pip.installed:
    - name: python-gnupg

  file.managed:
    - name: /tmp/RPM-GPG-KEY
    - source: https://keys.anydesk.com/repos/RPM-GPG-KEY
    - source_hash: 2dc9334f6a1c6c6c5d755835164b43744b61cdb0482935db4e2aa9063d74212e6d849b314bbf96307cadc82b450a76bb86ae91a47f6640ba7359dff649f25a2b

  cmd.wait:
    - name: rpm --import /tmp/RPM-GPG-KEY
    - watch:
      - file: /tmp/RPM-GPG-KEY

  module.run:
    - name: gpg.trust_key
    - fingerprint: B3EC086C879504FDB3EA93D063220853F3F033B1
    - trust_level: marginally
    - parallel: true
    - require:
      - pip: python-gnupg

add custom repositories:
  pkgrepo.managed:
    - names:
      - repo-anydesk-stable:
        - humanname: AnyDesk (Stable)
        - mirrorlist: http://rpm.anydesk.com/opensuse/$basearch/
        - gpgcheck: true
        - gpgautoimport: true
      - repo-dbeaver-community:
        - humanname: DBeaver (Community)
        - mirrorlist: https://download.opensuse.org/repositories/home:/Dead_Mozay/openSUSE_Tumbleweed/
        - gpgkey: https://download.opensuse.org/repositories/home:/Dead_Mozay/openSUSE_Tumbleweed/repodata/repomd.xml.key
        - gpgcheck: true
        - gpgautoimport: true
    - refresh: true
    - require:
      - cmd: authenticate repositories
      - module: authenticate repositories
    - require_in:
      - pkg: install packages

install packages:
  pkg.installed:
    - parallel: true
    - pkgs:
        - 7zip
        - alsa
        - anydesk
        - aria2
        - awesome
        - bat
        - btop
        - cloc
        - curl
        - dbeaver
        - discord
        - dog
        - exa
        - fd
        - ffmpeg
        - firefox
        - fzf
        - gdb
        - ghostscript
        - git
        - git-crypt
        - git-delta
        - gpg2
        - helvum
        - htop
        - hyperfine
        - jq
        - keepassxc
        - mpc
        - mpd
        - mpv
        - ncmpcpp
        - neovim
        - nmap
        - nodejs18
        - openfortivpn
        - openvpn
        - parallel
        - pipewire
        - pipewire-alsa
        - pipewire-pulse
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
        - scrot
        - simple-mtpfs
        - simple-scan
        - sqlite3
        - telegram-desktop
        - terraform
        - transmission
        - wezterm
        - wireplumber
        - wireshark
        - xclip
        - yq
        - zathura
        - zathura-plugin-pdf-poppler
        - zoxide
        - zsh

        - pattern:devel_basis
