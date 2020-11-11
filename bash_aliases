alias xrandr-fix-hdmi='xrandr --output LVDS-1 --auto --pos 0x0 --output HDMI-1 --auto --pos 1600x0 --primary'
alias update='sudo pacman -Syu'
alias fix-internet='sudo systemctl stop NetworkManager && sudo systemctl disable NetworkManager && sudo systemctl enable NetworkManager && sudo systemctl start NetworkManager && sudo systemctl status NetworkManager'
alias SpotifyDownload='cd && bash ~/OneDrive/SpotifyDownload.sh'
