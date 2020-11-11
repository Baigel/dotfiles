#!/bin/bash
adb tcpip 5555
adb connect 192.168.8.3:5555
sleep 1
scrcpy --bit-rate 2M --max-size 800
