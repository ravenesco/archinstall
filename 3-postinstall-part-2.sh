#!/bin/bash

username="hope"

# /opt/$username folder
sudo mkdir /opt/$username
sudo chown -R $USER:$GROUP /opt/$username

# Setup rust for paru installation
sudo pacman -Syu --needed --noconfirm rustup
rustup default stable

# Install paru
cd /opt/$username
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# NVIDIA Drivers
paru -Syu --needed --noconfirm nvidia-dkms
# paru -Syu --needed --noconfirm nvidia-open-dkms
paru -Syu --needed --noconfirm lib32-nvidia-utils nvidia-utils nvidia-settings

# Install "Possibly missing firmware" (some packages are from AUR)
paru -Syu --needed --noconfirm aic94xx-firmware ast-firmware linux-firmware-qlogic \
  wd719x-firmware upd72020x-fw

# Some fonts
paru -Syu --needed --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore \
  ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation wqy-zenhei ttf-mona-sans apple-fonts \
  ttf-ms-fonts nerd-fonts ttf-maple

# Display managers
paru -Syu --needed --noconfirm ly

## Hyprland
paru -Syu --needed hyprland hyprpaper hyprpicker hyprpolkitagent \
  hyprshot hyprland-qtutils hyprutils xdg-desktop-portal-hyprland hyprgraphics \
  egl-wayland qt5 qt6 qt5-wayland qt6-wayland playerctl uwsm wofi xsel mako waybar wl-clipboard \
  libva-nvidia-driver wlr-randr pyprland swayidle swaylock swaylock-fancy cmake meson cpio \
  pkg-config

## Hyprland (Git)
# paru -Syu --needed --noconfirm hyprland-git hyprpaper-git hyprpicker-git hyprpolkitagent-git \
#   hyprshot-git hyprland-qtutils-git hyprutils-git xdg-desktop-portal-hyprland-git hyprgraphics-git \
#   egl-wayland qt5 qt6 qt5-wayland qt6-wayland playerctl uwsm wofi xsel mako waybar wl-clipboard \
#   libva-nvidia-driver wlr-randr pyprland-git swayidle swaylock swaylock-fancy-git cpio


## i3
paru -Syu --needed xorg i3 autotiling dex maim polybar

## Awesome
paru -Syu --needed xorg awesome lain rofi picom polkit-gnome acpi arc-icon-theme

# Sync pkg database (needed for command-not-found zsh plugin to work)
sudo pkgfile -u

# Enable services
sudo systemctl enable ly
sudo systemctl enable NetworkManager

# Create custom $HOME directories
mkdir /home/$username/{AI_Tools,Games,Mounts,My,Media,Misc,Code}
