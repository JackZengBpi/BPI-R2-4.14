Kernel 4.14 for BPI-R2

## Requirements

Need cross compile tools for the armhf architecture and additional bison and flex-package:
```sh
sudo apt-get install gcc-arm-linux-gnueabihf libc6-armhf-cross u-boot-tools bc make gcc libc6-dev libncurses5-dev libssl-dev bison flex
```
## Issues
currently gcc7 is not supported (https://bugs.linaro.org/show_bug.cgi?id=3823)
```sh
sudo apt-get install gcc-5-arm-linux-gnueabihf
sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-7  50
update-alternatives: using /usr/bin/arm-linux-gnueabihf-gcc-7 to provide /usr/bin/arm-linux-gnueabihf-gcc (arm-linux-gnueabihf-gcc) in auto mode
sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-5  100
update-alternatives: using /usr/bin/arm-linux-gnueabihf-gcc-5 to provide /usr/bin/arm-linux-gnueabihf-gcc (arm-linux-gnueabihf-gcc) in auto mode

sudo update-alternatives --config arm-linux-gnueabihf-gcc
```

## Usage

```sh
  ./build.sh importconfig
  ./build.sh config
  ./build.sh
```

## Branch details

Kernel upstream + BPI-R2
* 4.14-main
* 4.9-main
* 4.16-main
* 4.17-main
* 4.18-rc

## Kernel version

Kernel breakdown features by version

|          | 4.4 | 4.9 | 4.14 | 4.16 | 4.17 | 4.18 |
|----------| --- | --- | --- | --- | --- | --- |
| PCIe     |  Y  |  Y  |  Y  |  Y  |     |   ?  |
| SATA     |  Y  |  Y  |  Y  |  Y?  |     |  Y   |
| 2 GMAC   |  Y  |  Y  |  Y  |  N  |     |     |
| DSA      |  N  |  Y  |  Y  |  Y  |  Y  |   Y  |
| USB      |  Y  |  Y  |  Y  |  Y?  |     |  ?   |
| VLAN     |     |     |  Y  |     |     |  ?   |
| HW NAT   |     |  Y  |  Y |     |     |     |
| HW QOS   |     |  Y  |  ? |     |     |     |
| Crypto   |  Y  |  Y  |  Y  |  Y?  |     |     |
| WIFI     |     |     |  Y  |  Y |  Y  |   Y  |
| BT       |     |     |     |     |     |     |
| VIDEO    |  Y  |  N  |  Y  |  Y  |     |     |
| ACPI |  ?  |  N  |  Y  |  N  |     |     |
||| other Options ||||     |
| OpenVPN  |  ?  |  Y  |  Y  |  ?  |     |   ?  |
| iptables |  ?  |  ?  |  Y  |  ?  |     |   ?  |
| LXC / Docker |  ?  |  ?  |  Y  |  ?  |     |  ?   |

? = unsure

() = testing (separate Branch wlan/hdmi/hwnat/hwqos)

HW-NAT only works between LAN and WAN (bridge unclear, wifi not working)
HW-QoS is merged into 4.14-main, but we do not know how to test it
ACPI-feature means System is powered off, not only halted (power-consumption ~0.2W, no reboot on reset), reboot-problem with soldered power-switch (see https://github.com/frank-w/BPI-R2-4.14/issues/35). Power-off is also initiated by pressing the power-switch
VIDEO is hdmi-output (X-server/framebuffer-console)...here some resolutions are not supported by vendor-driver

kernel 4.4 / uboot: https://github.com/frank-w/BPI-R2-4.4

## Links

* BPI-R2: http://www.banana-pi.org/r2.html
* Kernel: https://www.kernel.org/ , Stable-RC: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
* linux-mediatek: https://patchwork.kernel.org/project/linux-mediatek/list/, Threaded: http://lists.infradead.org/pipermail/linux-mediatek/
* kernelci: https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/
* Forum: http://forum.banana-pi.org/c/Banana-Pi-BPI-R2
* Wiki: http://www.fw-web.de/dokuwiki/doku.php?id=en/bpi-r2/start

License
----

GPL-2.0

**Free Software, Hell Yeah!**
