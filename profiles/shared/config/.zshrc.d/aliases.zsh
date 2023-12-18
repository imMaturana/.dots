# safety reasons
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias srm='shred -zuv'

# mkdir
alias mkdir='mkdir -p'

# cd
alias '..'='cd ..'
alias '.2'='cd ../..'
alias '.3'='cd ../../..'
alias '.4'='cd ../../../..'
alias '.5'='cd ../../../../..'

# bluetooth
alias bt='bluetoothctl'
alias bton='bluetoothctl power on'
alias btoff='bluetoothctl power off'

# distrobox
alias db='distrobox'
alias dbcr='distrobox create --no-entry'
alias dbrm='distrobox rm'

# termbin
alias tb='nc termbin.com 9999'
