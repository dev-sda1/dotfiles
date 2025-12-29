#!/usr/bin/env bash
set -e

## This acts as a one-stop setup file for dotfiles, and certain software.
## Verified working with Fedora 43.

if [ $(id -u) -ne 0 ]
    then echo "This should be run as sudo."
    exit -1
fi

## Full system update first..
dnf update -y

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf config-manager setopt fedora-cisco-openh264.enabled=1

dnf install akmod-nvidia -y
dnf install xorg-x11-drv-nvidia-cuda -y

dnf group install development-tools -y
dnf install git -y

## Enabling hyprland COPR repository
dnf copr enable solopasha/hyprland -y
dnf copr enable scottames/ghostty -y

## VSCode keys
rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Packages

dnf install python3 -y
dnf install pip3 -y
dnf install -y pavucontrol
dnf install code -y
dnf install hyprland -y
dnf install hyprpaper -y
dnf install hyprlock -y
dnf install ghostty -y
dnf install neovim -y
dnf install rofi -y
dnf install waybar -y
dnf install gammastep -y
dnf install slurp -y
dnf install jetbrains-mono-fonts-all -y

# Other packages
dnf install steam -y
dnf install telegram-desktop -y

mkdir -p /home/${SUDO_USER}/.local/bin/
wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/refs/heads/master/rofi-power-menu -O /home/${SUDO_USER}/.local/bin/rofi-power-menu
chmod +x /home/${SUDO_USER}/.local/bin/rofi-power-menu

echo -e "\n Copying config files"

mkdir -p /home/${SUDO_USER}/.config
cp -r ${PWD}/ghostty /home/${SUDO_USER}/.config/
cp -r ${PWD}/hypr /home/${SUDO_USER}/.config/
cp -r ${PWD}/nvim /home/${SUDO_USER}/.config/
cp -r ${PWD}/rofi /home/${SUDO_USER}/.config/
cp -r ${PWD}/waybar /home/${SUDO_USER}/.config/

echo -e "\n Fully complete! Restart system to finish."