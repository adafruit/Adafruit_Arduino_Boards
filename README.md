# Adafruit Arduino Boards

Configuration and other support files to use Adafruit's boards like Trinket, 
Pro Trinket, Gemma, Flora, and more with the Arduino IDE.  This is provided as
a reference for modifying the Arduino IDE to support Adafruit's boards.  If you
just want to program one of Adafruit's boards you probably want one of the 
preconfigured Arduino IDEs that Adafruit provides--see the learn system guide for
your board for more details!

These files are only compatible with the 1.6.x series of Arduino IDE and NOT the
earlier 1.0.x series.  Starting from a fresh Arduino 1.6.x IDE install navigate
to the Arduino IDE folder and copy in files as follows:

-   hardware/adafruit: This hiearchy of files should be copied into the hardware
    folder.

-   hardware/tools/avr/etc/avrdude.conf: This is a customized avrdude.conf that
    should be copied directly over the hardware/tools/avr/etc/avrdude.conf file
    in the Arduino IDE.  The modified configuration increases the delays when
    programming the ATtiny85 used in the Gemma and Trinket boards.

-   drivers: This folder contains USB drivers for Windows 8, 7, and XP.  The USB
    drivers should be installed when a Flora board is connected to the computer.

NOTE: Arduino IDE version 1.6.2 has a bug with supporting external cores and
DOES NOT work with these files.  Use Arduino 1.6.3+, or an earlier version like
1.6.1.

## Easy Install Scripts

Three shell scripts exist in the root that can simplify the creation of
modified Arduino IDEs with Adafruit's boards.  The scripts are build_linux.sh,
build_windows.sh, and build_macosx.h and they require bash, tar, zip, and unzip
(so they should really be run on Linux or OSX, however they have only been
tested on Linux).  Each script takes two parameters, the first it the name of
an input file that should be the Arduino IDE download for that platform, and
the second is the output file.

For example the IDE builds Adafruit publishes were built with commands like:

./build_linux.sh arduino-1.6.4-linux32.tar.xz adafruit-arduino-1.6.4-linux32.tar.xz

./build_linux.sh arduino-1.6.4-linux64.tar.xz adafruit-arduino-1.6.4-linux64.tar.xz

./build_windows.sh arduino-1.6.4-windows.zip adafruit-arduino-1.6.4-windows.zip

./build_macosx.sh arduino-1.6.4-macosx.zip adafruit-arduino-1.6.4-macosx.zip

## Running a Package Build

Run the `build_package.sh` script and enter a new version:
```
$ ./build_package.sh 
VERSION [1.3.0]: 1.3.0
``` 

The resulting `tar.bz2` archive will then be available in the `build/` folder along with the JSON output needed to add the new version to the package index file in the [adafruit/arduino-board-index](https://github.com/adafruit/arduino-board-index) repo:

```
├── build
│   ├── adafruit-1.3.0.tar.bz2
│   └── package.json
```
