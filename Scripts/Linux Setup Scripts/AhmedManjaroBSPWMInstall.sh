#!/bin/bash

# *************** BAIGEL's MANJARO BSPWM INSTALL ***************
# Important: Run system update before executing this script.
# Programs Installed Overview: 
# Settings Tweaked Overview: 

# System Update
#pacman -Syyu --noconfirm??
pacman-key --refresh-keys

# Uninstall Unused Software
pacman -Rsn --noconfirm bauh gimp hexchat manjaro-hello epdfview

# Install Software
# Software from Official Arch Repository
pacman -S --noconfirm chromium kate discord dictd steam xorg-xev manjaro-pulse player-ctl xdotool
# Software AUR Programs
AURPrograms=( yay spotify spotify-adblock-git flameshot-git menutray github-desktop-git scrcpy google-keep-nativefier )
mkdir aur-programs
cd aur-programs
for i in "${AURPrograms[@]}"
    do
    git clone "https://aur.archlinux.org/"$i".git"
    cd $i
    makepkg -si --noconfirm $i
    cd ..
    done

# Get Audio Working
install_pulse #fix this (no confirm)

# Replace bspwm config file with config from github


reboot






