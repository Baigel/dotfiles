#!/bin/bash

# Very much a hack, can break real easy

# Add SWAP drive to GRUB
DRIVE="/dev/sda1"
SWAP_DRIVE=$(echo $DRIVE | cut -d "/" -f 3)
SWAP_UUID=$(lsblk -o +UUID | grep "$SWAP_DRIVE" | grep "SWAP" | awk '{print $NF}')
sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=UUID=$SWAP_UUID /g" /etc/default/grub
# sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$DRIVE/g" /etc/default/grub

# Reload GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Add resume to initramfs HOOKS
#mkinitcpio -A resume
sed -i "s/HOOKS=(base udev autodetect keyboard modconf block filesystems fsck)/HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)/g" /etc/mkinitcpio.conf

# Regenerate initramfs
mkinitcpio -p linux
