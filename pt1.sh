#!/bin/bash

loadkeys ru
setfont cyr-sun16

echo "cfdisk"
echo "Standart for me : efi - 1G root - 30G home - остаток"
cfdisk

echo "formating"
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -L root /dev/sda2
mkfs.btrfs -L home /dev/sda3

echo "mounted"
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

echo "install base system"
pacstrap -i /mnt btrfs-progs base base-devel linux-zen linux-zen-headers linux-firmware nano git sudo
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "chroot enter"
arch-chroot /mnt /bin/bash