profile="$src/profiles/sway"
cfg_dir="$profile/config"

sway_dotfiles=(
	# desktop
	"$cfg_dir/.config/sway"
	"$cfg_dir/.config/waybar"
	"$cfg_dir/.config/swaylock"
	"$cfg_dir/.config/foot"
	"$cfg_dir/.config/fuzzel"
	"$cfg_dir/.config/kanshi"
	"$cfg_dir/.config/mako"

	# mpd
	"$cfg_dir/.config/mpd"
	"$cfg_dir/.config/ncmpc"

	# zathura
	"$cfg_dir/.config/zathura"
)

readarray -t sway_packages < "$profile/packages"
readarray -t sway_flatpak_packages < "$profile/flatpak_packages"

# install pipewire
sudo apt install pipewire pipewire-audio

# enable pipewire services
systemctl --user enable --now \
	pipewire.service \
	pipewire-pulse.service \
	wireplumber.service

unset $profile
unset $cfg_dir
