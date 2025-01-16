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

# Apps
paru -Syu --needed --noconfirm brave-bin librewolf-bin terminator ghostty \
  zstd mlocate mpv bat bat-extras fastfetch lolcat bind man-db tealdeer lsd htop qbittorrent \
  uv keepassxc obs-studio ocs-url downgrade dolphin ark gwenview yazi \
  tauon-music-box digikam calibre komikku filelight imagemagick ticktick less gnome-disk-utility\
  thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin \
  thunar-vcs-plugin ripgrep gnome-font-viewer font-manager reflector unzip pavucontrol flatpak \
  media-downloader-git tumbler network-manager-applet stow tmux discover pamac okular \
  gitnuro-bin xclicker freetube pkgfile man-pages openvpn networkmanager-openvpn mcomix wget \
  nodejs npm gvfs gvfs-mtp android-tools virtualbox cava zoxide bluez bluez-utils blueman \
  yt-dlp cliphist xclip copyq bc xdotool scrot maim brightnessctl feh swww gnome-calculator fd \
  neovim-nightly neovim-telescope-fzf-native-git neovim-telescope-ui-select-git fzf luarocks \
  nwg-look lxappearance-gtk3 zukitwo-themes-git tela-circle-icon-theme-dracula gearlever \
  archlinux-xdg-menu

# GIMP-devel (might refuse to install and break installation of the rest packages,
# and thus commented for now; safer to install separately afterwards)
# paru -Syu --needed --noconfirm gimp-devel

# Packages for OBS virtual camera setup
paru -Syu --needed --noconfirm guvcview guvcview-qt pipewire-v4l2 v4l2loopback-dkms \
  v4l2loopback-utils lib32-pipewire-v4l2

# Some fonts
paru -Syu --needed --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore \
  ttf-dejavu ttf-droid ttf-ibm-plex ttf-liberation wqy-zenhei ttf-mona-sans apple-fonts \
  ttf-ms-fonts nerd-fonts ttf-maple

## Gaming tools
paru -Syu --needed --noconfirm steam lutris wine-staging protonup-qt-bin gamemode lib32-gamemode \
  mangohud lib32-mangohud

# Wine dependencies (from lutris github)
paru -Syu --needed --asdeps --noconfirm giflib lib32-giflib gnutls lib32-gnutls v4l-utils \
  lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib \
  lib32-alsa-lib sqlite lib32-sqlite libxcomposite lib32-libxcomposite ocl-icd lib32-ocl-icd \
  libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs \
  vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

# Display manager
paru -Syu --needed --noconfirm ly

## Awesome
paru -Syu --needed --noconfirm xorg awesome lain rofi picom polkit-gnome acpi
mkdir -p /home/$username/.config/awesome
git clone https://github.com/streetturtle/awesome-wm-widgets.git /home/$username/.config/awesome

## Hyprland
paru -Syu --needed --noconfirm hyprland-git hyprpaper-git hyprpicker-git hyprpolkitagent-git \
  hyprshot-git hyprland-qtutils-git hyprutils-git xdg-desktop-portal-hyprland-git hyprgraphics-git \
  egl-wayland qt5 qt6 qt5-wayland qt6-wayland playerctl uwsm wofi xsel mako waybar wl-clipboard \
  libva-nvidia-driver wlr-randr pyprland-git swayidle swaylock swaylock-fancy-git cpio

# Setup Hyprland plugins
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit

# Sync pkg database (needed for command-not-found zsh plugin to work)
sudo pkgfile -u

# Setup tmux
# git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Install flatpaks
flatpak install flathub com.github.vikdevelop.timer
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub org.bionus.Grabber

# Enable services
systemctl --user enable pipewire
sudo systemctl enable ly
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth.service

# Add user to newly created groups
sudo usermod -aG vboxusers $username

# Create custom $HOME directories
mkdir /home/$username/{AI_Tools,Games,Mounts}
