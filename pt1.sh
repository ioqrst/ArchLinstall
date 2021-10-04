#!/bin/bash

loadkeys ru
setfont cyr-sun16

echo "Разметка диска"
echo "Стандартно для меня выглядит так : efi - 1G root - 30G home - остаток"
cfdisk

echo "Форматирование"
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -L root /dev/sda2
mkfs.btrfs -L home /dev/sda3

echo "Монтирование разделов"
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

echo "Установка базовой системы"
pacstrap -i /mnt btrfs-progs base base-devel linux-zen linux-zen-headers linux-firmware nano git sudo
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Переход в chroot"
arch-chroot /mnt /bin/bash