#!/usr/bin/env sh

# Install packages
pacman -Syu $(xargs < ./packages/devel.txt) --noconfirm --needed


# Get the dotfiles
dotfiles_dir="/tmp/Dotfiles"

if [ ! -d $dotfiles_dir ]; then
    git clone "https://github.com/El-Wumbus/Dotfiles" $dotfiles_dir
fi


install -D "${dotfiles_dir}/nvim" "$HOME/.config/nvim"