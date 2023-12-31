#!/bin/bash

LOG_FILE="logs/necessities.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "$(date +"%H:%M:%S"): $1"
}

# System update
log "Starting system update..."
sudo pacman -Syu --noconfirm
log "System updated. Proceeding..."

cd /home

# Install yay
if ! command -v yay &>/dev/null; then
    log "yay is not installed. Downloading and installing..."
    
    # Install git if not already installed
    if ! command -v git &>/dev/null; then
        log "git is not installed. Installing..."
        sudo pacman -S --noconfirm git
        log "git has been installed!"
    else
        log "git is already installed!"
    fi
    
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd - || exit
    log "yay has been installed!"
else
    log "yay is already installed!"
fi

# Install nano
if ! command -v nano &>/dev/null; then
    log "nano is not installed. Installing..."
    sudo pacman -S --noconfirm nano
    log "nano has been installed!"
else
    log "nano is already installed!"
fi

# Install NVIM
if ! command -v nvim &>/dev/null; then
    log "NVIM is not installed. Downloading and installing..."
    sudo pacman -S neovim --noconfirm
    log "NVIM has been installed!"

    # sleep command
    sleep 5
fi

# Install konsole
sudo pacman -S --noconfirm konsole

# Install pipewire + counterparts
sudo pacman -Syu
sudo pacman -S --noconfirm pipewire pipewire-pulse pw-volume

# Install CMake
if ! command -v cmake &>/dev/null; then
    log "CMake is not installed. Installing..."
    sudo pacman -S --noconfirm cmake
    log "CMake has been installed!"
else
    log "CMake is already installed!"
fi