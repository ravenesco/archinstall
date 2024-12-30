#!/bin/bash

# Create and mount btrfs and its subvolumes
mkfs.fat -F 32 /dev/nvme0n1p1
fatlabel /dev/nvme0n1p1 ESP

mkswap -L SWAP /dev/nvme0n1p2
swapon /dev/disk/by-label/SWAP

mkfs.btrfs -L ROOT -f /dev/nvme0n1p3
mount /dev/disk/by-label/ROOT /mnt

btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@.snapshots
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@run@media
btrfs su cr /mnt/@var

umount -R /mnt
mount -o noatime,compress=zstd,space_cache=v2,subvol=@ /dev/nvme0n1p3 /mnt
mkdir -p /mnt/{boot,var,home,.snapshots,tmp,run/media}
mount -o noatime,compress=zstd,space_cache=v2,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,subvol=@var /dev/nvme0n1p3 /mnt/var
mount -o noatime,compress=zstd,space_cache=v2,subvol=@tmp /dev/nvme0n1p3 /mnt/tmp
mount -o noatime,compress=zstd,space_cache=v2,subvol=@run@media /dev/nvme0n1p3 /mnt/run/media

mkdir -p /mnt/boot/efi
mount /dev/disk/by-label/ESP /mnt/boot/efi


# Install base system
pacstrap /mnt base base-devel linux linux-firmware linux-headers intel-ucode nano git git-lfs \
  glibc pacman-contrib curl
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
