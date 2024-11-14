

# Install "Possibly missing firmware" (some packages are from AUR)
paru -Sy --needed --noconfirm aic94xx-firmware ast-firmware linux-firmware-qlogic wd719x-firmware upd72020x-fw

# Apps
paru -Sy --needed --noconfirm brave-bin wezterm kitty zstd mlocate mpv bat fastfetch lolcat bind man-db tealdeer \
lsd htop qbittorrent pyenv keepassxc obs-studio librewolf ocs-url downgrade dolphin neovim 

# Some fonts
paru -Sy --needed --noconfirm gnu-free-fonts noto-fonts ttf-bitstream-vera ttf-croscore ttf-dejavu \
ttf-droid ttf-ibm-plex ttf-liberation wqy-zenhei ttf-mona-sans apple-fonts ttf-ms-fonts

## Gaming tools
paru -Sy --needed --noconfirm steam lutris wine-staging

# Wine dependencies (from lutris github)
paru -Sy --needed --asdeps --noconfirm giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

## Hyprland
paru -S --needed ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite libxrender \
pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio \
tomlplusplus hyprlang-git hyprcursor-git hyprwayland-scanner-git xcb-util-errors hyprutils-git \
egl-wayland qt5-wayland qt6-wayland playerctl sddm uwsm hyprland hyprpolkitagent-git wofi \
swaync hyprpaper hyprlock hyprpolkitagent-git waybar hyprland-git

# Enable more services
systemctl --user enable pipewire
sudo systmctl enable sddm

# /opt/hope folder
sudo mkdir /opt/hope
sudo chown -R $USER:$GROUP /opt/hope
