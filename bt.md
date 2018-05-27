Draft

[8BitDo Controllers](https://github.com/recalbox/recalbox-os/wiki/8bitdo-on-recalbox-(EN))

```bash
tail -f  /recalbox/share/system/logs/recalbox.log
```

# Raspberry

List BT neighbourhood

```bash
cd /recalbox/scripts
./recalbox-config.sh hcitoolscan
```

Internal script:

```bash
cd /recalbox/scripts
./recalbox-config.sh hiddpair "E2:07:18:E2:19:89" "8Bitdo NES30 Pro"
```

When device ask a PIN code (when not reset)

```bash
/recalbox/scripts/bluetooth/test-device list
    98:A2:F9:32:6F:0A Pro Controller
 
/recalbox/scripts/bluetooth/simple-agent hci0 98:A2:F9:32:6F:0A
    Agent registered
    RequestPinCode (/org/bluez/hci0/dev_98_A2_F9_32_6F_0A)
    Enter PIN Code: 0000
    Device paired
```

# Odroid

Start `bluetoothctl` then type the following commands

```
agent on
default-agent
power on
scan on
```

Wait until bluetoothctl lists your device then

```
pair AA:BB:CC:DD:EE:FF
connect AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
```
