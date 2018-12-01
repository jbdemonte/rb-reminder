My setup:

I code on a Mac laptop, and build on a dedicated, device-less, PC

I usually use some dedicated scripts to build either the whole Recalbox image, or only the EmulationStation package, which is the one I mainly work on.

# Build scripts for Recalbox

[build script for recalbox](scripts/build.sh)

This script :
- copy my locale git repository for recalbox on the PC 
- run the build command on the PC

[build script for emulationstation](scripts/build_es.sh)

This script: 
- copy my locale git repository for the EmulationStation package on the PC
- run the build command on the PC
- stop the emulationstation on the Pi / Odroid 
- copy the EmulationStation binary on the Pi / Odroid
- start the binary on the Pi / Odroid

# Misc 

When buiding manually on the PC:

I build using `screen` to detach the terminal ([screen](https://doc.ubuntu-fr.org/screen))

```bash
screen -S build
ARCH=rpi3 scripts/linux/recaldocker.sh
```

Then [CTRL]+[a] then [d] to detach

Useful commands:
`screen -ls` to list available screens
`screen -r` to attach an existing screen
`screen -r name` to attach the screen by its name (when having multiples screens available)

