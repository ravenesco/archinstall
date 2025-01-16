#!/bin/bash

# Timezone setup
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
hwclock --systohc

# Hostname
echo "Havoc" > /etc/hostname

# Hosts file setup
echo "# Standard host addresses
127.0.0.1  localhost
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
# This host address
127.0.1.1  Havoc

# Block vscode RATs
127.0.0.1   *.tunnel.api.visualstudio.com
127.0.0.1   *.devtunnels.ms" > /etc/hosts

# Essential packages
pacman -Syu --needed --noconfirm ntfs-3g grub efibootmgr os-prober dosfstools mtools mkinitcpio \
  zsh btrfs-progs grub-btrfs pipewire lib32-pipewire pipewire-pulse pipewire-alsa pipewire-audio \
  wireplumber alsa-utils net-tools dhcpcd wpa_supplicant networkmanager brightnessctl sudo

# Grub Setup
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch BTW" --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# Setup a user
echo "Root password"
passwd
username="hope"
useradd -m -G wheel,audio,video,optical,storage $username
echo "User password"
passwd $username
chsh -s /usr/bin/zsh $username
chsh -s /usr/bin/zsh root

## Add CachyOS repos
# Import the repository key
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
# Sign the repository key
sudo pacman-key --lsign-key F3B607488DB35A47
# Install the necessary packages
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst' \
'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.0.0.r6.gc685ae6-2-x86_64.pkg.tar.zst'

# Switch to a normal user
su $username
