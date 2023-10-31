function ex() {
    for file in "$@"; do
        case "$file" in
            *.tar.gz|*.tar.xz|*.tgz|*.txz|*.tar)
                tar zxvf "$file" ;;
            *.zip|*.epub)
                unzip "$file" ;;
        esac
    done
}

function open() {
    for file in "$@"; do
        case "$file" in
            *.opus|*.ogg|*.md4) mpv "$file" ;;
            *.html) xdg-open "$file" ;;
            *.pdf) zathura "$file" ;;
            *.jpg|*.jpeg|*.png) imv "$file" ;;
            *.txt|*.md) cat "$file" | less ;;
        esac
    done
}

function ,() {
    if [ -f /run/.containerenv ]; then
        flatpak-spawn --host -- "$@"
        return
    fi

	distrobox enter -- "$@"
}

