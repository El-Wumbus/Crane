#!/usr/bin/env sh
SCRIPTPATH=$(dirname "$SCRIPT")

# Install packages
sudo pacman -Syu $(xargs < ./packages/desktop.txt) --noconfirm --needed

git clone "https://aur.archlinux.org/yay.git" /tmp/yay
cd /tmp/yay || exit 1
makepkg -si
cd "$SCRIPTPATH" || exit 1

yay -S $(xargs < ./packages/desktop_aur.txt) --noconfirm --needed

# Get the dotfiles
dotfiles_dir="/tmp/Dotfiles"

if [ ! -d $dotfiles_dir ]; then
    git clone "https://github.com/El-Wumbus/Dotfiles" $dotfiles_dir
fi

mkdir -p "$HOME/.config"
install -D "${dotfiles_dir}/alacritty" "$HOME/.config/alacritty"
install -D "${dotfiles_dir}/alacritty" "$HOME/.config/alacritty"
install -D "${dotfiles_dir}/i3" "$HOME/.config/i3"
install -D "${dotfiles_dir}/picom" "$HOME/.config/picom"
install -D "${dotfiles_dir}/alacritty" "$HOME/.config/alacritty"
install -D "${dotfiles_dir}/sxhkd" "$HOME/.config/sxhkd"
sudo install -D "${dotfiles_dir}/wallpapers/*" "/usr/share/wallpapers/"
