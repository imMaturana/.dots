profile="$src/profiles/plasma"
cfg_dir="$profile/config"

profile_dotfiles=()

readarray -t profile_packages < "$profile/packages"
readarray -t profile_flatpak_packages < "$profile/flatpak_packages"

unset $profile
unset $cfg_dir
