export EDITOR=vim
export PATH=~/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

# enable terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export ANSIBLE_NOCOWS=1
export ANSIBLE_RETRY_FILES_ENABLED=false

alias ytdl="youtube-dl -f best --no-check-certificate"
alias tmux="TERM=screen-256color-bce tmux"
alias rscp='rsync --archive --xattrs --acls --progress --rsh="ssh"'

# source ~/bin/oc_completion.sh

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi
