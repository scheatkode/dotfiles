# `usbreset`

Headphones be like: *« I'mma bring you back to 1970 where mono was still the
$h!t »*

This is me wasting 15 minutes because I’m too lazy to get up and remove the
headphone USB cable for the fourth time today.

```bash
❯ lsusb
Bus 002 Device 001: ID xxxx:xxxx Linux Foundation 3.0 root hub
Bus 001 Device 004: ID xxxx:xxxx Genesys Logic, Inc. Hub
Bus 001 Device 003: ID xxxx:xxxx MOSART Semi. 2.4G Wireless Mouse
Bus 001 Device 002: ID xxxx:xxxx Logitech, Inc. Keyboard K120
Bus 001 Device 007: ID xxxx:xxxx Intel Corp. AX201 Bluetooth
Bus 001 Device 006: ID xxxx:xxxx ASUSTek Computer, Inc. AURA LED Controller
```

Then do your thing, simple as that.

```bash
❯ sudo ./usbreset /dev/bus/usb/002/001
```
