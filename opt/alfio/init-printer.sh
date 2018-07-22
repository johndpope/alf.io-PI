#!/bin/bash
device_name=$(/opt/alfio/device-name.sh $1)
if [ "$2" == "ZD410" ]; then
    /usr/sbin/lpadmin -E -p "Alfio-ZBR-${device_name}" -v "usb://Zebra%20Technologies/ZTC%20ZD410-203dpi%20ZPL?serial=$1" -m drv:///sample.drv/zebra.ppd -o printer-error-policy=abort-job -o printer-is-shared=false
    /usr/bin/lpoptions -p "Alfio-ZBR-${device_name}" -o usb-unidir-default=true -o Darkness=30
    /usr/sbin/cupsenable "Alfio-ZBR-${device_name}"
    /usr/sbin/cupsaccept "Alfio-ZBR-${device_name}"
    /sbin/rmmod usblp
else
    /usr/sbin/lpadmin -E -p "Alfio-DYM-${device_name}" -v "usb://DYMO/LabelWriter%20450%20Turbo?serial=$1" -P /usr/share/cups/model/lw450t.ppd -o printer-error-policy=abort-job -o printer-is-shared=false
fi
echo ${device_name}