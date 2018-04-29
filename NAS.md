Make the system writable
```
mount -o remount,rw /boot
```

Edit the file `vi /boot/recalbox-boot.conf`

```
sharedevice=NETWORK

sharenetwork_smb1=BIOS@192.168.0.10:Public/recalbox/bios:guest
sharenetwork_smb2=ROMS@192.168.0.10:Public/recalbox/roms:guest
sharenetwork_smb3=SAVES@192.168.0.10:Public/recalbox/saves:guest
```
