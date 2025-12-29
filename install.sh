#!/usr/bin/env bash
set -e

## This acts as a one-stop setup file for dotfiles, and certain software.
## Verified working with Fedora 43.
##
## TODO: Waydroid install and Configure for Apple Music Support.

## Full system update first..
sudo dnf update -y

sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

sudo dnf install akmod-nvidia -y
sudo dnf install xorg-x11-drv-nvidia-cuda -y

sudo dnf group install development-tools -y
sudo dnf install git -y

## Enabling hyprland COPR repository
sudo dnf copr enable solopasha/hyprland -y
sudo dnf copr enable scottames/ghostty -y

## VSCode keys
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Packages

sudo dnf install python3 -y
sudo dnf install pip3 -y
sudo dnf install pavucontrol -y
sudo dnf install code -y
sudo dnf install hyprland -y
sudo dnf install hyprland-qtutils -y
sudo dnf install hyprpaper -y
sudo dnf install hyprlock -y
sudo dnf install ghostty -y
sudo dnf install neovim -y
sudo dnf install rofi -y
sudo dnf install waybar -y
sudo dnf install gammastep -y
sudo dnf install slurp -y
sudo dnf install jetbrains-mono-fonts-all -y
sudo dnf install curl -y

# Other packages
sudo dnf install steam -y
sudo dnf install telegram-desktop -y

mkdir -p /home/${USER}/.local/bin/
wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/refs/heads/master/rofi-power-menu -O /home/${USER}/.local/bin/rofi-power-menu
chmod +x /home/${USER}/.local/bin/rofi-power-menu

echo -e "\nNow configuring ZSH.."
sudo dnf install -y zsh
chsh $USER -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || echo "oh-my-zsh already installed.."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /home/${USER}/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\n Copying config files"

mkdir -p /home/${USER}/.config
cp -r ${PWD}/ghostty /home/${USER}/.config/
cp -r ${PWD}/hypr /home/${USER}/.config/
cp -r ${PWD}/nvim /home/${USER}/.config/
cp -r ${PWD}/rofi /home/${USER}/.config/
cp -r ${PWD}/waybar /home/${USER}/.config/

echo -e "\n Fully complete! Restart system to finish."