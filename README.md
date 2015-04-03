# Adafruit Arduino Boards

Configuration and other support files to use Adafruit's boards like Trinket, 
Pro Trinket, Gemma, Flora, and more with the Arduino IDE.  This is provided as
a reference for modifying the Arduino IDE to support Adafruit's boards.  If you
just want to program one of Adafruit's boards you probably want one of the pre-
configured Arduino IDEs that Adafruit provides--see the learn system guide for
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
DOES NOT work with these files.  Use Arduino 1.6.3, or an earlier version like
1.6.1.
