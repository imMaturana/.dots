profile="$src/profiles/plasma"
cfg_dir="$profile/config"

plasma_dotfiles=()

readarray -t plasma_packages < "$profile/packages"
readarray -t plasma_flatpak_packages < "$profile/flatpak_packages"

unset $profile
unset $cfg_dir
