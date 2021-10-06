#!/bin/bash

read -p "Enter user name: " uname
useradd -m -g users -G wheel -s /bin/bash $uname
passwd $uname

echo "uncomment %wheel ALL=(ALL) ALL (first after root)"
EDITOR=nano visudo

pacman -S xorg xorg-xinit xorg-server
