libvirtd enable modular services:
  service.running:
    - names:
      - virtinterfaced-admin.socket
      - virtinterfaced-ro.socket
      - virtinterfaced.socket
      - virtlockd-admin.socket
      - virtlockd.socket
      - virtlogd-admin.socket
      - virtlogd.socket
      - virtnetworkd-admin.socket
      - virtnetworkd-ro.socket
      - virtnetworkd.socket
      - virtnodedevd-admin.socket
      - virtnodedevd-ro.socket
      - virtnodedevd.socket
      - virtnwfilterd-admin.socket
      - virtnwfilterd-ro.socket
      - virtnwfilterd.socket
      - virtqemud-admin.socket
      - virtqemud-ro.socket
      - virtqemud.socket
      - virtsecretd-admin.socket
      - virtsecretd-ro.socket
      - virtsecretd.socket
      - virtstoraged-admin.socket
      - virtstoraged-ro.socket
      - virtstoraged.socket
{#- Enable for remote management #}
      # - virtproxyd.socket
      # - virtproxyd-admin.socket
      # - virtproxyd-ro.socket
      # - virtproxyd-tcp.socket
      # - virtproxyd-tls.socket
    - enable: true
    - parallel: true
    - require:
        pkg: install packages
