#!/bin/bash

username="hope"

# Setup Hyprland plugins
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit

# Setup Awesome widgets
mkdir -p /home/$username/.config/awesome
git clone https://github.com/streetturtle/awesome-wm-widgets.git /home/$username/.config/awesome/awesome-wm-widgets

# Apps
paru -Syu --needed brave-bin librewolf-bin terminator ghostty \
  zstd mlocate mpv bat bat-extras fastfetch lolcat bind man-db tealdeer lsd htop qbittorrent \
  uv keepassxc obs-studio ocs-url downgrade dolphin ark gwenview yazi \
  tauon-music-box digikam calibre komikku filelight imagemagick ticktick less gnome-disk-utility\
  thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin \
  thunar-vcs-plugin ripgrep gnome-font-viewer font-manager reflector unzip pavucontrol flatpak \
  media-downloader-git tumbler network-manager-applet stow tmux discover okular \
  gitnuro-bin xclicker freetube pkgfile man-pages openvpn networkmanager-openvpn mcomix wget \
  nodejs npm podman gvfs gvfs-mtp android-tools virtualbox virtualbox-guest-utils \
  virtualbox-host-dkms cava zoxide bluez bluez-utils blueman \
  yt-dlp cliphist xclip copyq bc xdotool scrot maim brightnessctl feh swww gnome-calculator fd \
  neovim-nightly neovim-telescope-fzf-native-git neovim-telescope-ui-select-git fzf luarocks \
  nwg-look lxappearance-gtk3 gradience zukitwo-themes-git tela-circle-icon-theme-dracula gearlever \
  archlinux-xdg-menu shortwave vesktop mkdocs mkdocs-material thefuck vscodium-bin \
  vscodium-bin-features vscodium-bin-marketplace python-yapsy-git darktable rawtherapee mypaint \
  gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive \
  gvfs-smb gvfs-wsdd obsidian freefilesync syncthing

# Controversial due to snapd requirements: pamac-all

# Gradience relies on yapsy, so installing it here
paru -Syu --needed --noconfirm gradience

# Install flatpaks
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.github.vikdevelop.timer
flatpak install flathub org.bionus.Grabber

# GIMP-devel (might refuse to install and break installation of the rest packages,
# and thus commented for now; safer to install separately afterwards)
paru -Syu --needed --noconfirm gimp-devel

# Packages for OBS virtual camera setup
paru -Syu --needed --noconfirm guvcview guvcview-qt pipewire-v4l2 v4l2loopback-dkms \
  v4l2loopback-utils lib32-pipewire-v4l2

## Gaming tools
# With CachyOS repos
sudo pacman -S cachyos-gaming-meta
paru -Sy --needed protonup-qt-bin gamemode lib32-gamemode mangohud lib32-mangohud fuse-overlayfs drawfs-bin
# CachyOS Proton
paru -Syu --needed --noconfirm lib32-lzo lib32-blas lib32-lapack proton-cachyos

# Without CachyOS repos
# paru -Syu --needed --noconfirm steam lutris wine-staging

# Wine dependencies (from lutris github)
# paru -Syu --needed --asdeps --noconfirm giflib lib32-giflib gnutls lib32-gnutls v4l-utils \
#   lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib \
#   lib32-alsa-lib sqlite lib32-sqlite libxcomposite lib32-libxcomposite ocl-icd lib32-ocl-icd \
#   libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs \
#   vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

# Emulators
paru -Syu --needed --noconfirm torzu-git

# Setup tmux
# git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Enable services
systemctl --user enable pipewire
sudo systemctl enable bluetooth.service
sudo systemctl enable podman

# Add user to newly created groups
sudo usermod -aG vboxusers $username
