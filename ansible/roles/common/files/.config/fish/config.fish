set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

#connecting to a previously created session
#a new window is created in a new session
#closing the window closes the terminal
#avoid nesting instances

# autorun tmux, for UID != 0 (without VScode env error)
# set -l UID (awk -v user=$USER -F":" '{ if($1==user){print $3} }' /etc/passwd)
# if test $UID -ne 0 && test ! $TMUX;
#   exec tmux
# end

set PATH $PATH ~/.local/bin
export PATH

source "$HOME/.config/fish/aliases.fish"

