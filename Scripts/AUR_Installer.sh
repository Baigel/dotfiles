# Software AUR Programs and other community packages
cd ~
mkdir -p aur-programs
cd aur-programs
AURPrograms=( yay spotify steam-fonts tllocalmgr-git )
echo "\${AURPrograms}"
for i in "\${AURPrograms[@]}"
	do
	echo "Package: \$i"
	{
	git clone "https://aur.archlinux.org/\$i.git"
	cd \$i
	makepkg -si --noconfirm \$i
	cd ..
	} || echo "Package \$i not found!"
done
cd
rm -rf ~/aur-programs
