#!/bin/bash

read -p "Enter user name: " uname
useradd -m -g users -G wheel -s /bin/bash $uname
passwd $uname

EDITOR=nano visudo

nano /etc/pacman.conf

pacman -Syyu --noconfirm
pacman -S xorg xorg-xinit xorg-server xorg-server-devel --noconfirm
