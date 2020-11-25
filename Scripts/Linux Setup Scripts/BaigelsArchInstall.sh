#!/bin/bash

# *************** BAIGEL's ARCH INSTALL ***************
# Run system update before executing this script.

# Basic Overview
# This script requires an internet connection ("ip link" for interface name; "wifi-menu -o [interfaceName]" to connect)
# Desktop Environment:	KDE(?)
# Window Manager:	Spectrwm

set -ex

# Prompt user with inital warning
echo 'WARNING: THIS SCRIPT WILL BLINDLY WIPE THE DISK!'
echo 'Press Enter to continue...'
read -s

# System Details
DRIVE='/dev/sda'
TIMEZONE='Australia/Brisbane'
KEYMAP='us'

# Get hostname and username
echo 'Enter username'
read USERNAME
echo 'Enter hostname: '
read HOSTNAME

# Get Password
echo -n "Password: "
read -s PASSWORD
echo
echo -n "Repeat Password: "
read -s PASSWORD2
echo
[[ "$PASSWORD" == "$PASSWORD2" ]] || ( echo "Passwords did not match; exiting now."; exit 1; )


# Setup Logging
echo 'Enabling logging'
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")


# Update system clock
echo 'Update system clock'
timedatectl set-ntp true


# Setup Partitioning
echo ' --- Setting Up Boot and Swap Partitions --- '
echo 'Partitioning the disk'
boot_dev="$DRIVE"1
swap_dev="$DRIVE"2
swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
swap_end=$(( $swap_size + 129 + 1 ))MiB
parted --script "${device}" -- mklabel gpt \
  mkpart ESP fat32 1Mib 129MiB \
  set 1 boot on \
  mkpart primary linux-swap 129MiB ${swap_end} \
  mkpart primary ext4 ${swap_end} 100%

# Format filesystem
echo 'Formatting filesystem'
mkfs.ext4 -L boot "$boot_dev"
mkswap "$swap_dev"
# Mounting filesystem
echo 'Mounting filesystem'
mount "$boot_dev" /mnt/boot
swapon "$swap_dev"

# Find the boot/swap/root partitions using a glob and then wipe the filesystems
part_boot="$(ls ${device}* | grep -E "^${device}p?1$")"
part_swap="$(ls ${device}* | grep -E "^${device}p?2$")"
part_root="$(ls ${device}* | grep -E "^${device}p?3$")"
wipefs "${part_boot}"
wipefs "${part_swap}"
wipefs "${part_root}"

# Write the partitions and mount
mkfs.vfat -F32 "${part_boot}"
mkswap "${part_swap}"
mkfs.f2fs -f "${part_root}"
swapon "${part_swap}"
mount "${part_root}" /mnt
mkdir /mnt/boot
mount "${part_boot}" /mnt/boot

# Install important packages using pacstrap
echo ' --- Installing Base --- '
pacstrap /mnt base linux linux-firmware


# Install Base
#echo ' --- Installing Base --- '
#echo 'Install essential packages'
#echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
#pacstrap /mnt base base-devel
#pacstrap /mnt syslinux
# Absolute chad just gonna assume that chroot worked
#echo 'Unmounting filesystems'
#umount /mnt/boot
#umount /mnt
#swapoff /dev/vg00/swap
#vgchange -an

#
#echo ' --- Entering Chroot --- '
#cp $0 /mnt/setup.sh
#arch-chroot /mnt ./setup.sh chroot


# Configure the system
echo ' --- Configuring the System --'
echo 'Generating the fstab file'
genfstab -U /mnt >> /mnt/etc/fstab
echo 'Entering chroot to continue install'
arch-chroot /mnt
echo 'Setting timezone'
ln -sf /usr/share/zoneinfo/Australia/Brisbane /etc/localtime
echo 'Generating /etc/adjtime'
hwclock --systohc
echo 'Setting localization'
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
locale-gen
echo 'Set keymap'
echo 'KEYMAP=de-latin1' >> /etc/vconsole.conf
echo 'Setting hostname and configuring network'
echo "$HOSTNAME" >> /etc/hostname
echo "127.0.0.1	localhost\n::1		localhost\n127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME" >> /etc/hosts
echo 'Adding user'
useradd -m -s /bin/zsh -G adm,systemd-journal,wheel,rfkill,games,network,video,audio,optical,storage,scanner,power,adbusers,wireshark "$USERNAME"
echo 'Setting root password'
echo -en "$PASSWORD\n$PASSWORD" | passwd
echo 'Setting user password'
echo -en "$PASSWORD\n$PASSWORD" | passwd $USERNAME
echo 'Adding user as a sudoer'
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers
chmod 440 /etc/sudoers
echo 'Enable dhcpcd'
systemctl enable dhcpcd
echo 'Setting up microde'
echo 'microcode' > /etc/modules-load.d/intel-ucode.conf
echo 'Enable systemctl services'
systemctl enable cronie.service cpupower.service ntpd.service slim.service
echo 'Enable systemctl wifi services'
systemctl enable net-auto-wired.service net-auto-wireless.service
echo 'Updating locate'
updatedb

echo ' --- Installing Bootloader (grub) --- '
pacman -S grub os-prober
grub-install --recheck --target=i386-pc /dev/sda1
grub-mkconfig -o /boot/grub/grub.cfg
echo 'Exiting'
exit
umount -R /mnt


# System Update
#pacman -Syyu --noconfirm??


# Fix Pacman Key issues (?)
gpg --keyserver hkp://keys.gnupg.net --recv-keys 4773BD5E130D1D45  # Used for fixing spotify (may need to change regularly idk)
pacman-key --refresh-keys

# Fix rofi font issue (?)
# Download https://gitlab.manjaro.org/profiles-and-settings/desktop-settings/blob/master/community/bspwm/skel/.config/rofi/config.rasi and place into ~/.config/rofi


# Uninstall Unused Software (?)
pacman -Rsn --noconfirm bauh gimp hexchat manjaro-hello mousepad xfce-screenshooter thunderbird transmission-gtk pidgin xfburn orage audacious lxterminal zathura-djvu zathura-pdf-poppler zathura gtkhash-thunar thunar-archive-plugin thunar-media-tags-plugin thuar-shares-plugin thunar-volman thunar



# Set Wallpaper
git clone
# Need to make the following wallpaper change permanent
feh --bg-scale ~/.wallpaper


# Install atom addons
apm install save-workspace

# Finish Up
reboot

# Functions

install_packages() {
	# Install Software
	IDEs="visual-studio-code-bin atom"
	TERMINAL="konsole exa ranger dictd xorg-xev playerctl xdotool screenfetch feh"
	LATEX="texlive-core texlive-latexextra texlive-science pdftk"
	OTHER="discord steam dolphin"
	TOOLS="manjaro-pulse"
	# Fix up keys (?)
	sudo pacman-key --refresh-keys
	sudo pacman -Sy --noconfirm archlinux-keyring && sudo pacman -Su --noconfirm
	sudo hwclock -w
	# Software from Official Arch Repository
	pacman -S --noconfirm $IDES $TERMINAL $LATEX $OTHER
	# Software AUR Programs
	AURPrograms=( yay spotify spotify-adblock-git flameshot-git github-desktop-git scrcpy google-keep-nativefier tllocalmgr-git )
	cd ~
	mkdir aur-programs
	cd aur-programs
	for i in "${AURPrograms[@]}"
		do
		git clone "https://aur.archlinux.org/"$i".git"
		cd $i
		makepkg -si --noconfirm $i
		cd ..
	done
	cd
	rm -rf ~/aur-programs
	# Install Doom Emacs
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
	~/.emacs.d/bin/doom install
}

get_dot_files() {
	# Replace config files with config files from github
	# Awesome config
	#git clone
	# Autorun on start file
	#git clone
	# Flameshot config file
	#git clone
}


