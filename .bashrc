# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export RESTIC_REPOSITORY="sftp:rsync:data-backup"
export PATH="$HOME/bin:$PATH"

# shortcuts
export d="$HOME/code/dotfiles"
export gls="$HOME/code/gls"
export c="$HOME/code/gls/ad0014l"

alias vale="$HOME/bin/vale/bin/vale"
alias wb="sk flamel && rm -rf guides/tmp && flamel sg"
alias wsm="scp 'guides/tmp/en-US/pdf/*.pdf' macbook:Desktop"
alias wp="zathura 'guides/tmp/en-US/pdf/*.pdf' &"
alias m="aerc"
alias n="newsboat"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '
