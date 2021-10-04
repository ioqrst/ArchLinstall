#!/bin/bash

read -p "Enter PC name: " 

nano /etc/locale.gen

locale-gen

echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo "$pcname" > /etc/hostname
echo "127.0.1.1 localhost.localdomain $pcname" /etc/hosts

pacman -S networkmanager
systemctl enable NetworkManager

echo "root password"
passwd

pacman -S grub efibootmgr

mkdir /boot/efi
mount /dev/sda1 /boot/efi

lsblk

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
grub-mkconfig -o /boot/grub/grub.cfg

exit
