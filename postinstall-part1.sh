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
  wireplumber net-tools dhcpcd wpa_supplicant networkmanager brightnessctl

# Grub Setup
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch BTW" --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# Setup a user
useradd -m -G wheel,audio,video,optical,storage hope
passwd hope
chsh -s /usr/bin/zsh hope
chsh -s /usr/bin/zsh root

# Switch to a normal user
su hope
