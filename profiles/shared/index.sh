profile="$src/profiles/shared"
cfg_dir="$profile/config"

shared_dotfiles=(
	# zsh
	"$cfg_dir/.zshrc"
	"$cfg_dir/.zshrc.d"
	"$cfg_dir/.zprofile"

	# git
	"$cfg_dir/.config/git"

	# tmux
	"$cfg_dir/.config/tmux"

	# distrobox
	"$cfg_dir/.config/distrobox"

	# neovim
	"$cfg_dir/.config/nvim"

    # emacs
    "$cfg_dir/.emacs.d"

	# VSCodium
	"$cfg_dir/.config/VSCodium/User/settings.json"

	# podman quadlets
	"$cfg_dir/.config/containers/systemd"
)

readarray -t shared_packages < "$profile/packages"
readarray -t shared_flatpak_packages < "$profile/flatpak_packages"

unset $profile
unset $cfg_dir
