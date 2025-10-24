# General
alias history "history --show-time='%F %T '"

alias cat "grc cat"
alias tail "grc tail"
alias head "grc head"

alias ll "ls -alF"
alias la "ls -A"
alias l "ls -CF"

# rename-move with confirmation without correction
alias mv "mv -i"
# recursive copy with confirmation without correction
alias cp "cp -iR"
# deletion with confirmation without correction
alias rm "rm -i"
# forced deletion without correction
alias rmf "rm -f"
# forced recursive deletion without correction
alias rmrf "rm -fR"

# Arch
alias togz "tar czvpf"
alias tobz  "tar cjvpf"
alias untar "tar xvpf"

# Apt
alias api "sudo apt install"
alias upd "sudo apt update"
alias upg "sudo apt full-upgrade"
alias dupg "sudo apt dist-upgrade"
alias purge "sudo apt purge --auto-remove"
alias acs "apt search"
alias auu "sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt purge --auto-remove"

# Other
alias mc "mc -S gotar"
alias rg "ranger"
#alias rg 'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`busybox cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias unp "udisksctl unmount -b $1 && udisksctl power-off -b $1"
alias df "duf"

# Wireguard
alias wgup "sudo wg-quick up $1"
alias wgdown "sudo wg-quick down $1"
alias wgshow "sudo wg show $1"

# Network
alias pubip "dig +short myip.opendns.com @resolver1.opendns.com"

# Git
alias g "git"
alias gu "git add . && git commit -m 'update' && git push"

#Wget
# Download full site
alias reget "wget -r -k -l 7 -p -E -nc"
