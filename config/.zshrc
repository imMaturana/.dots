if [ -f /etc/zsh/zshrc ]; then
    . /etc/zsh/zshrc
fi

# prompt
PS1='%n@%m %~ $ '

# set completion
autoload -Uz compinit && compinit

# path
export PATH=$PATH:~/.local/bin

# source rc files
if [ -d .zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		. "$rc"
	done
fi

# use starship if available
if command -v starship >/dev/null; then
	eval "$(starship init zsh)"
fi

