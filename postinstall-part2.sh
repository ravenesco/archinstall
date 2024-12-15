#!/bin/bash

# /opt/hope folder
sudo mkdir /opt/hope
sudo chown -R $USER:$GROUP /opt/hope

# Setup rust for paru installation
sudo pacman -Syu --needed --noconfirm rustup
rustup default stable

# Install paru
cd /opt/hope
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# NVIDIA Drivers
paru -Syu --needed --noconfirm nvidia-open lib32-nvidia-utils nvidia-utils nvidia-settings

# Install "Possibly missing firmware" (some packages are from AUR)
paru -Syu --needed --noconfirm aic94xx-firmware ast-firmware linux-firmware-qlogic wd719x-firmware upd72020x-fw

# Apps
paru -Syu --needed --noconfirm brave-bin wezterm kitty alacritty terminator tabby-bin zstd mlocate mpv bat bat-extras fastfetch lolcat bind \
man-db tealdeer lsd htop qbittorrent python-pipenv keepassxc obs-studio librewolf-bin ocs-url downgrade neovim-nightly dolphin \
ark gwenview lf tauon-music-box digikam calibre filelight gimp-devel imagemagick ticktick less thunar thunar-volman \
thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin thunar-vcs-plugin ripgrep gnome-font-viewer \
reflector unzip nwg-look pavucontrol media-downloader-git tumbler network-manager-applet stow tmux discover \
pamac okular gitnuro-bin xclicker freetube pkgfile man-pages openvpn networkmanager-openvpn mcomix spotify spotifywm-git \
spicetify-cli spicetify-marketplace-bin wget nodejs npm gvfs gvfs-mtp android-tools virtualbox cava zoxide yazi \
bluez bluez-utils blueman tela-circle-icon-theme-dracula yt-dlp cliphist bc xdotool scrot maim feh brightnessctl swww

# Some fonts
paru -Syu --needed --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu \
ttf-droid ttf-ibm-plex ttf-liberation wqy-zenhei ttf-mona-sans apple-fonts ttf-ms-fonts nerd-fonts \
ttf-maple

## Gaming tools
paru -Syu --needed --noconfirm steam lutris wine-staging

# Wine dependencies (from lutris github)
paru -Syu --needed --asdeps --noconfirm giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

## Hyprland
paru -Syu --needed --noconfirm hyprland-git hyprshot hyprpicker egl-wayland qt5 qt6 qt5-wayland qt6-wayland playerctl ly uwsm \
hyprpolkitagent-git wofi xsel swaync hyprpaper hyprlock waybar wl-clipboard xclip cliphist libva-nvidia-driver wlr-randr \
xdg-desktop-portal-hyprland-git

# Sync pkg database (needed for command-not-found zsh plugin to work)
sudo pkgfile -u

# Setup tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Enable services
systemctl --user enable pipewire
sudo systemctl enable ly
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth.service
