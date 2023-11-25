profile="$src/profiles/gnome"
cfg_dir="$profile/config"

gnome_dotfiles=()

readarray -t gnome_packages < "$profile/packages"
readarray -t gnome_flatpak_packages < "$profile/flatpak_packages"

unset $profile
unset $cfg_dir
