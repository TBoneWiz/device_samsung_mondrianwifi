This is Linux screen binary recompiled for Android 5.0 and above. 
It does not require external libncurses library, but only can be invoked from root terminal.

Usage (to connect to USB-Serial adapter on 9600 baud rate):

root# screen /dev/ttyUSB0 9600

Adapter MUST be plugged in before invoking screen and screen will immediately terminate if the adapter is disconnected.
