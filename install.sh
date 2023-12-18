#!/usr/bin/env bash

src=$(cd "${0%/*}"; pwd)
selected_profile="${1:-gnome}"

case $selected_profile in
	sway|gnome|plasma) ;;
	*) echo "Profile $selected_profile does not exists." && exit 1 ;;
esac

# declare some arrays
declare -A dotfiles
declare -A packages
declare -A flatpak_packages

# source the shared and $selected_profile dots
source ./profiles/shared/index.sh
source ./profiles/$selected_profile/index.sh

# append the shared dots to arrays
dotfiles+=${shared_dotfiles[@]}
packages+=${shared_packages[@]}
flatpak_packages+=${shared_flatpak_packages[@]}

# append the $selected_profile dotfiles
case $selected_profile in
	sway)
		dotfiles+=${sway_dotfiles[@]}
		packages+=${sway_packages[@]}
		flatpak_packages+=${sway_flatpak_packages[@]}
		;;
	gnome)
		dotfiles+=${gnome_dotfiles[@]}
		packages+=${gnome_packages[@]}
		flatpak_packages+=${gnome_flatpak_packages[@]}
		;;
	plasma)
		dotfiles+=${plasma_dotfiles[@]}
		packages+=${plasma_packages[@]}
		flatpak_packages+=${plasma_flatpak_packages[@]}
		;;
esac

# install packages
sudo apt install --no-install-recommends ${packages[@]}

# install flatpak
sudo apt install flatpak

# setup flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# install flatpak packages
flatpak install flathub -y ${flatpak_packages[@]}

# symlink dotfiles
for dot in ${dotfiles[@]}; do
	dot_src=$dot
	dot_out="$HOME/${dot##*/config/}"
	dir_out=$(dirname $dot_out)

	[ ! -d $dir_out ] && mkdir -p $dir_out

	if [ ! -e $dot_out ]; then
		ln -s $dot_src $dot_out
	fi
done
