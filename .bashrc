# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export RESTIC_REPOSITORY="sftp:rsync:data-backup"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/code/dotfiles/scripts:$PATH"

# shortcuts
export d="$HOME/code/dotfiles"
export gls="$HOME/code/gls"
export c="$HOME/code/gls/AD0014L"

alias vale="$HOME/bin/vale/bin/vale"
alias wb="sk build pdf"
alias m="aerc"
alias n="newsboat"
alias sk="~/code/gls/scaffolding/sk"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '
