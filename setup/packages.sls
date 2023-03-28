add anydesk repository:
  pkgrepo.managed:
    - humanname: AnyDesk (Stable)
    - mirrorlist: http://rpm.anydesk.com/opensuse/$basearch/
    - gpgcheck: 1
    - gpgkey: https://keys.anydesk.com/repos/RPM-GPG-KEY

add dbeaver repository:
  pkgrepo.managed:
    - humanname: DBeaver (Community)
    - mirrorlist: https://download.opensuse.org/repositories/home:/Dead_Mozay/openSUSE_Tumbleweed/
    - gpgcheck: 1
    - gpgkey: https://download.opensuse.org/repositories/home:/Dead_Mozay/openSUSE_Tumbleweed/repodata/repomd.xml.key

  module.run:
    - name: gpg.trust_key
    - fingerprint: B3EC086C879504FDB3EA93D063220853F3F033B1

dotfiles.packages.install:
  pkg.installed:
    - require:
        - pkgrepo: add anydesk repository
        - module: add dbeaver repository
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
