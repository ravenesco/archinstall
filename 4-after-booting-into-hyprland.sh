#!/bin/bash

username="hope"

# Setup Hyprland plugins
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit

# Setup Awesome widgets
mkdir -p /home/$username/.config/awesome
git clone https://github.com/streetturtle/awesome-wm-widgets.git /home/$username/.config/awesome/awesome-wm-widgets

# Install flatpaks
flatpak install flathub com.github.vikdevelop.timer
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub org.bionus.Grabber
