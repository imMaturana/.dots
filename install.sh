#!/usr/bin/env bash

src=$(cd "${0%/*}"; pwd)

dotfiles=(
	# zsh
	.zshrc
	.zshrc.d
	.zprofile

	# git
	.config/git

	# desktop / sway
	.config/sway
	.config/waybar
	.config/kanshi
	.config/foot
	.config/fuzzel
	.config/swaylock
	.config/mako

	# text editor
	.config/nvim
	.emacs.d
	.config/VSCodium/User/settings.json

	# tmux
	.config/tmux/tmux.conf

	# distrobox
	.dbox

	# mpd
	.config/mpd
	.config/ncmpc

	# zathura
	.config/zathura
)

# install common packages
sudo apt install $(< $src/common_packages)

# install pipewire and setup services
pipewire_setup() {
	sudo apt install pipewire pipewire-audio

	systemctl --user enable --now \
		pipewire.service \
		pipewire-pulse.service \
		wireplumber.service
}
pipewire_setup

# install flatpak, setup flathub and install packages
flatpak_setup() {
	sudo apt install flatpak

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub $(< $src/flatpak_packages)
}
flatpak_setup

# install catppuccin gtk theme
catppuccin_theme_install() {
	local tmp_dir=$(mktemp -d)
	local themes_dir=$HOME/.local/share/themes
	local theme='Catppuccin-Mocha-Standard-Blue-dark'
	local version='0.6.1'

	# download package
	wget "https://github.com/catppuccin/gtk/releases/download/v${version}/${theme}.zip" -P $tmp_dir

	# unzip
	[ ! -d $themes_dir ] && mkdir -p $themes_dir
	unzip $tmp_dir/$theme.zip -d $themes_dir

	# make theme available for flatpak
	ln -s $themes_dir ~/.themes
	flatpak override --filesystem=$HOME/.themes
}
catppuccin_theme_install

# install nerd font
nerdfont_install() {
	local tmp_dir=$(mktemp -d)
	local fonts_dir=$HOME/.local/share/fonts
	local font='CascadiaCode'
	local version='3.0.2'
	local out=$fonts_dir/$font

	# download font
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${font}.tar.xz" -P $tmp_dir

	# untar
	[ ! -d $fonts_dir ] && mkdir -p $fonts_dir
	mkdir -p $out
	tar -xf $tmp_dir/${font}.tar.gz -C $out
}
nerdfont_install

# setup and enable systemd services
systemd_user_services() {
	local out=$HOME/.config/systemd/user

	[ ! -d $out ] && mkdir -p $out

	for service in ./systemd/*.{service,target}; do
		cp $service $out/${service##.*/}

        if [ "${service##*.}" = "service" ]; then
            systemctl --user enable --now ${service##.*/}
        fi
	done
}
systemd_user_services

# symlink the configuration files
for cfg in ${dotfiles[@]}; do
	src_cfg=$src/config/$cfg
	out_cfg=$HOME/$cfg
	out_dir=$(dirname $out_cfg)

	[ ! -d $out_dir ] && mkdir -p $out_dir

	if [ ! -e $out_cfg ]; then
		ln -s $src_cfg $out_cfg
	fi
done
