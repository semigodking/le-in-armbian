# le-in-armbian
Running LibreElec in Armbian

## Purpose
The purpose is to run KODI from LibreElec in Armbian with most of features
available, especially HDMI CEC. The only reason for me is that building KODI
with features enabled is not an easy job. I have no security concern.

## My Hardware
[NanoPC-T4](http://wiki.friendlyarm.com/wiki/index.php/NanoPC-T4)

## Steps
### Install Armbian
Please follow [Armbian][Armbian] [official user guide](https://docs.armbian.com/User-Guide_Getting-Started/) to install Armbian to
your hardware. For RK3399 hardware, I would recommend you install latest version
with legacy kernel.

### Build and Replace Kernel
This step may be optional for other hardwares. If HDMI CEC is not important for
you, you can also skip this step. By default, legacy kernel (4.4.x) does not have
CEC driver enabled. We need to change default config to enable kernel module and
rebuild kernel.

Follow [Building Armbian](https://docs.armbian.com/Developer-Guide_Build-Preparation/) to build and replace kernel.

### Install Xwayland
I did not do tests wihtout wayland drivers. Not sure if this step is optional.
```bash
sudo apt update
sudo apt install xwayland
```
### Build Root FS for KODI
Download LibreElec image from [LibreElec][LibreElec].
I use [legacy kernel image for RockPro64](http://releases.libreelec.tv/LibreELEC-RK3399.arm-9.2.6-rockpro64.img.gz) for NanoPC-T4.
Run bash command to build rootfs. During execution of this script, you will
be prompt for password for sudo.
```bash
./build-rootfs.sh LibreELEC-RK3399.arm-9.2.6-rockpro64.img.gz
```
### Run KODI
The commands below are just for you to verify KODI's functionality. More work
need to be done to make KODI a service startup with system.

```bash
mount --bind /dev rootfs/dev
chroot rootfs /bin/bash /start_kodi.sh
```
You may mount folders with media files into rootfs so that files can be
accessed. You could also modify the `start\_kodi.sh` script to add your
mouns.

By far, I use this command to start KODI.
```
unshare --mount-proc -p -f -r -R rootfs/ /start_kodi.sh
```

### Auto Start
Simple systemd file examples are put in folder `systemd`. You need to edit the
those files and install the `libreelec.service` in systemd. Besure to change
environment ROOTFS to correct path.

## Performance
This solution works quite well for me. Hardware acceleration works as well as
HDMI CEC. H256 HW decode also works.

## Known Problems
* Keyboard and mouse not working

[LibreElec]: https://libreelec.tv/
[Armbian]: https://armbian.com/
