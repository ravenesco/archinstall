#!/bin/bash

# Create and mount btrfs and its subvolumes
mkfs.fat -F 32 /dev/nvme0n1p1
fatlabel /dev/nvme0n1p1 ESP

mkswap -L SWAP /dev/nvme0n1p2
swapon /dev/nvme0n1p2

mkfs.btrfs -L ROOT -f /dev/nvme0n1p3
mount /dev/disk/by-label/ROOT /mnt

btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@.snapshots
btrfs su cr /mnt/@var@log
btrfs su cr /mnt/@var@tmp

umount -R /mnt
mount -o noatime,compress=zstd,space_cache=v2,commit=120,subvol=@ /dev/nvme0n1p3 /mnt
mkdir -p /mnt/{boot/efi,var/log,var/tmp,home,.snapshots,tmp}
mount -o noatime,compress=zstd,space_cache=v2,commit=120,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,commit=120,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,commit=120,subvol=@var@log /dev/nvme0n1p3 /mnt/var/log
mount -o noatime,compress=zstd,space_cache=v2,commit=120,subvol=@var@tmp /dev/nvme0n1p3 /mnt/var/tmp

mount /dev/nvme0n1p1 /mnt/boot/efi


# Install base system
pacstrap /mnt base base-devel linux linux-headers linux-zen linux-zen-headers linux-firmware \
  intel-ucode nano git git-lfs glibc pacman-contrib curl
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
