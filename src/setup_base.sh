#!/usr/bin/env sh

# Setup Arch mirrors
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Install packages
pacman -Syu $(xargs < ./packages/base.txt) --noconfirm --needed

# Get the dotfiles
dotfiles_dir="/tmp/Dotfiles"

if [ ! -d $dotfiles_dir ]; then
    git clone "https://github.com/El-Wumbus/Dotfiles" $dotfiles_dir
fi

#
# Setup zsh
#

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh configuration
cp "$dotfiles_dir/zshrc" "$HOME/.zshrc"