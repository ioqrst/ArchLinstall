#!/bin/bash

loadkeys ru
setfont cyr-sun16
timedatectl set-ntp true

cfdisk

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.btrfs -L root /dev/sda3 -f
mkfs.btrfs -L home /dev/sda4 -f

mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
swapon /dev/sda2

pacstrap -i /mnt btrfs-progs base base-devel linux-zen linux-zen-headers linux-firmware nano git sudo --noconfirm

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash
